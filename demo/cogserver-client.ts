#!/usr/bin/env node
// TypeScript/Node.js CogServer client example
// SPDX-License-Identifier: Apache-2.0

import WebSocket from 'ws';

interface CogResponse {
  status: string;
  result: string;
  type: string;
}

async function askCogserver(expression: string, host = 'localhost', port = 18080): Promise<CogResponse> {
  return new Promise((resolve, reject) => {
    const ws = new WebSocket(`ws://${host}:${port}/json`);
    ws.on('open', () => {
      ws.send(JSON.stringify({ command: 'scheme', body: expression }));
    });
    ws.on('message', (data) => {
      resolve(JSON.parse(data.toString()));
      ws.close();
    });
    ws.on('error', reject);
    setTimeout(() => reject(new Error('Timeout')), 5000);
  });
}

async function main() {
  // Create atoms
  const r1 = await askCogserver('(Concept "typescript-demo")');
  console.log('Created:', r1.result);

  // Build inheritance
  const r2 = await askCogserver('(Inheritance (Concept "typescript-demo") (Concept "demo"))');
  console.log('Linked:', r2.result);

  // Count atoms
  const r3 = await askCogserver('(cog-count-atoms)');
  console.log('Total atoms:', r3.result);

  // Arithmetic
  const r4 = await askCogserver('(cog-evaluate! (Plus (Number 3) (Number 4)))');
  console.log('3 + 4 =', r4.result);
}

main().catch(console.error);
