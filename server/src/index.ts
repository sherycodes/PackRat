import { Hono } from 'hono';
import { fetchHandler } from 'trpc-playground/handlers/fetch';
// import { renderTrpcPanel } from 'trpc-panel';
import { appRouter } from './routes/trpcRouter';
import { honoTRPCServer } from './trpc/server';
import { cors } from 'hono/cors';

const app = new Hono();

app.use(
  '*',
  cors({
    origin: 'http://localhost:8081',
    credentials: true,
    allowHeaders: ['Content-Type', 'Authorization'],
    allowMethods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  }),
);

app.use(
  'api/trpc/*',
  honoTRPCServer({ router: appRouter, endpoint: '/api/trpc' }),
);

app.use('/trpc-playground', async (c, next) => {
  const handler = await fetchHandler({
    router: appRouter,
    trpcApiEndpoint: '/api/trpc',
    playgroundEndpoint: '/trpc-playground',
  });
  return handler(c.req.raw);
});

export default app;
