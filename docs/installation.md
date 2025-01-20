---
hide:
  - navigation
---

# Installation

The preferred method of installation for Lumin Framework is Pesde, although other methods are available if you don't use an external code editor.

## Pesde

Use a package manager to mix in other packages with Lumin Framework

1. Install Pesde using the [guide](https://docs.pesde.dev)
2. Add **lumin/framework** using `pesde add lumin/framework`
3. Install the package using `pesde install`
4. To update packages, use `pesde update`

## Roblox

Easily drag-and-drop the file into your game if using studio only

1. Open the [latest release](https://github.com/lumin-org/framework/releases/latest)
2. Download `Standalone.rbxm`
3. Drag and drop `Standalone.rbxm` into [ReplicatedStorage](https://create.roblox.com/docs/reference/engine/classes/ReplicatedStorage)

## Source

Building from source allows you to make edits in whatever ways you wish

1. Copy the *Git URL*: `https://github.com/lumin-org/framework.git`
2. Clone the repository to the current dir using `git clone <git url>`
3. Use [Pesde](https://pesde.dev) to install the neccesary CLIs and packages using `pesde install`
4. Sync the test files along with the build to Roblox using `rojo serve dev.project.json`
