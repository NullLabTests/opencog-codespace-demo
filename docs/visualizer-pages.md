# Visualizer Pages Guide

The OpenCog Visualizer provides six distinct views into the atomspace.
Launch it by opening `http://<host>:18080/visualizer/` in your browser.

## 1. Landing Page — `index.html`

The main screen showing the 3D graph. Atoms appear as colored spheres,
links as connecting lines. You can:

- **Click and drag** to rotate the view
- **Scroll** to zoom in / out
- **Right-click drag** to pan
- **Click an atom** to inspect its details (type, name, truth value, connections)

### Screenshot

![Visualizer Landing Page](../assets/visualizer.png)

## 2. Tree View — `tree-view.html`

A hierarchical (tree) layout of the atomspace. Best for understanding
inheritance and type hierarchies. Each atom is a node, and connected
atoms branch outward.

- **Collapse / expand** subtrees by clicking nodes
- **Color coding** by atom type
- Good for **class hierarchy visualization**

### Screenshot

![Tree View](../assets/tree-view.png)

## 3. Type View — `type-view.html`

A focused view showing the **type system** of the atomspace. Each atom
type (ConceptNode, InheritanceLink, EvaluationLink, etc.) is shown with
its instances.

- Shows the distribution of atom types
- Click a type to see its instances and connections
- Useful for understanding how the type system is being used

### Screenshot

![Type View](../assets/type-view.png)

## 4. Analytics — `analytics.html`

Statistical dashboard of the atomspace in real time:

- **Total atom count** (nodes + links)
- **Type distribution** (pie chart or bar chart)
- **Incoming/outgoing degree** histograms
- **Connection density** metrics
- Updates live as you add/remove atoms

### Screenshot

![Analytics Page](../assets/analytics.png)

## 5. JSON Test — `/websockets/json-test.html`

A developer tool for sending raw JSON commands to the CogServer over
WebSocket. Each command is a JSON object:

```json
{"command": "scheme", "body": "(Concept \"test\")"}
```

Response appears in the right-hand panel. Useful for debugging and
automation.

### Screenshot

![JSON Test Page](../assets/json-test.png)

## 6. WebSocket Shell — `/websockets/demo.html`

An interactive Atomese shell in the browser. Type commands, see results
in real time. Supports Scheme, Python, and JSON modes.

- **Connect** button establishes the WebSocket
- Input box accepts Atomese expressions
- Response area shows formatted results
- **Clear** button to reset the output

## Server Stats — `/stats`

Not part of the visualizer, but essential: the CogServer's HTTP stats
page shows:

- Loaded modules and their status
- Uptime and connection count
- Memory usage
- Active shell sessions

### Screenshot

![Stats Dashboard](../assets/stats-full.png)
