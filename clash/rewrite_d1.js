export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    const configUrl = url.searchParams.get('config'); // 从查询字符串获取订阅链接

    if (!configUrl) {
      return new Response('Missing config URL parameter', { status: 400 });
    }

    try {
      // 1. 从外部传入的订阅链接中获取初始的clash配置
      const configResponse = await fetch(configUrl, {
        headers: {
          'User-Agent': 'Clash'
        }
      });
      if (!configResponse.ok) {
        return new Response('Failed to fetch config', { status: configResponse.status });
      }
      let configText = await configResponse.text();

      // 2. 从DurableDB中获取自定义规则
      const { results } = await env.DB.prepare('SELECT * FROM rules').all();
      if (!results || results.length === 0) {
        return new Response('No custom rules found in DurableDB', { status: 500 });
      }

      // 使用正则表达式查找rules:部分
      const rulesRegex = /\s+rules:\s*\n/g;
      const match = rulesRegex.exec(configText);
      if (!match) {
        return new Response('Invalid config format: "rules" section not found', { status: 400 });
      }
      
      // 在rules:部分之前插入自定义规则
      const injectedRules = `rules:\n- ${results.map(row => row.rule.trim()).join('\n- ')}\n`;

      // 提取 rules: 后面的部分
      const remainingText = configText.slice(match.index + match[0].length);

       // 删除现有规则缩进
      const cleanedRemainingText = remainingText.replace(/^(\s*)- /gm, '- ');

      configText = `${configText.slice(0, match.index)}\n${injectedRules}${cleanedRemainingText}`;

      // 3. 向请求方响应修改后的配置文件
      return new Response(configText, {
        headers: {
          'Content-Type': 'text/plain; charset=utf-8',
        }
      });
    } catch (error) {
      return new Response('An error occurred: ' + error.message, { status: 500 });
    }
  }
}
