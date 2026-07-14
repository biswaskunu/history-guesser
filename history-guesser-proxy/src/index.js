export default {
  async fetch(request, env) {
    const BACKEND = "https://history-guesser.up.railway.app";

    const url = new URL(request.url);
    const targetUrl = BACKEND + url.pathname + url.search;

    // Forward the request as-is (method, headers, body)
    const proxied = new Request(targetUrl, {
      method: request.method,
      headers: request.headers,
      body: ["GET", "HEAD"].includes(request.method) ? undefined : request.body,
      redirect: "follow",
    });

    const response = await fetch(proxied);

    // Clone so we can safely return (Workers requires this for streamed bodies)
    return new Response(response.body, {
      status: response.status,
      statusText: response.statusText,
      headers: response.headers,
    });
  },
};