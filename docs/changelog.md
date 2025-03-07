# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Changed `Lifecycle` to `Hook` in favor of more accurate naming
- Shortened code in some areas (possible optimizations)

## [10.0.0] - 2025-01-29

### Removed

- Removed `New` in favor of using `Add` for all modules

## [10.0.0-rc5] - 2025-01-25

### Added

- Proper `rbxts` support - #39

## [10.0.0-rc4] - 2025-01-22

### Added

- Completely revamped documentation (guides and API)
- Added back `Lifecycles` (they're actually really good)

### Changed

- Changed the behavior of `Add`, now only gets children and not descendants

## [10.0.0-rc3] - 2025-01-21

### Removed

- Removed `Lifecycles`, they do not have much use

## [10.0.0-rc2] - 2025-01-20

### Fixed

- Move table freezing to init process instead of on creation
- Addresses really big issue with `Start` not being able to run

## [10.0.0-rc1] - 2025-01-04

## [9.1.1] - 2024-12-16

### Fixed

- Fixes an issue with start being in the incorrect order ([#29](https://github.com/luminlabsdev/framework/issues/29))

### Removed

- Removes default lifecycle types

## [9.0.1] - 2024-11-19

### Fixed

- Fixes an issue with initiation ([#28](https://github.com/luminlabsdev/framework/issues/28))

## [9.0.0] - 2024-10-10

### Fixed

- Fixes some issues that are related to yielding code unexpectedly ([#27](https://github.com/luminlabsdev/framework/issues/27))
- Fixes some docs issues

### Changed

- Improved the way lifecycles are loaded ([#26](https://github.com/luminlabsdev/framework/pull/26))

## [9.0.0-rc13] - 2024-09-25

### Added

- Added back ability to create default lifecycle types

### Changed

- Changed `Cycle` API to `Lifecycle` to be more concise

## [9.0.0-rc12] - 2024-09-23

### Changed

- Changes how controllers load to be more efficient

### Added

- Adds improved cycle APIs
- Adds load order option to controllers
- Add philosphy page in documentation

### Removed

- Removes `.Load` in favor of merging with `.Start`
- Removed default cycle types in favor of self-implementation

## [9.0.0-rc11] - 2024-09-22

### Fixed

- Fixes an error with controllers not loading

## [9.0.0-rc10] - 2024-09-21

### Fixed

- Fixes an issue with controller loading

## [9.0.0-rc9] - 2024-09-21

### Fixed

- Fixes `.Start` not being called in `Used` modules

### Changed

- Changes `Worker` to `Cycle`
- Changed docs style

### Removed

- Removes `OnStart` in favor of a callback within `Start`

## [9.0.0-rc8] - 2024-09-13

### Fixed

- Adds a fix for an incorrect type reference
- Simplifies controller type

## [9.0.0-rc7] - 2024-09-02

### Added

- Adds `Controller.Uses` as an optional table that contains every other controller that it uses

### Changed

- How workers are defined internally, much less code
- `.Controller` to `.New`, much less verbose and more general
- Controllers no longer need names upon creation
- Simplify internal code to be under 200 LOC

### Removed

- Removes `.Expect` for a better dependency system
- Removes `.Signal` for less bloat in favor of custom systems

## [9.0.0-rc6] - 2024-08-20

### Added

- Dependency injection
- New docs page

## [9.0.0-rc5] - 2024-08-14

### Fixed

- Fixes issue with Player based workers
- Fixed xpcall issues

### Changes

- Updates docs

## [9.0.0-rc4] - 2024-08-12

### Fixed

- Fixed issue with workers again

### Added

- Updated example place to include workers and better response times

## [9.0.0-rc3] - 2024-08-12

### Fixed

- Fixed some issues with github actions not working entirely
- Fixed some issues with invalid types in niche cases
- Fixed some issues with workers not being registered correctly

### Changed

- Changed where releases are drafted into a different job

## [9.0.0-rc2] - 2024-08-11

### Changed

- Changed github actions to be more precise and automate more tasks

### Removed

- Removed an internal type that was not working properly

## [9.0.0-rc1] - 2024-08-08

### Changed

- Adds .Controller to define controller objects
- Adds .Worker to define worker objects
- Adds .Start for streamlined working
- Networking is now a separate package, under LuminNet
- Adds improved debugging internally
- Improves docs a ton, adding tutorials for every aspect

### Removed

- Removes client and server interfaces

## 8.1.5 - 2024-07-23

### Fixed

- Fixed some github actions

## 8.0.5 - 2024-07-14

### Changed

- Fixes problems with .Load not working entirely correctly
- Fixes package list in docs
- Type validation will now error if incorrect

## 8.0.4 - 2024-07-07

### Changed

- Improves format of site and actions
- Fixes standalone not having properly exported package types (thanks @DrasticBlink)

## 8.0.3 - 2024-06-18

### Changed

- Fixes issue with existing network events/functions not being able to be defined multiple times

## 8.0.2 - 2024-05-24

### Changed

- Adds type references to init module as they were not accessible prior

## 8.0.1 - 2024-05-12

### Added

- Re-release due to wally issue

## 8.0.0 - 2024-05-12

### Added

- Adds reviews to docs home page

## 8.0.0-rc2 - 2024-05-04

### Changed

- Improve main module structure
- Fix typing bug with `.Load()`

## 8.0.2-rc1 - 2024-04-29

### Changed

- Fixes yielding bug on client when character does not load

## 8.0.1-rc1 - 2024-04-29

### Changed

- Fix networking interface issues

## 8.0.0-rc1 - 2024-04-28

### Added

- Improved networking system
- Better solutions to load modules during run time

### Changed

- Changed project name from **CanaryEngine** to **LuminFramework**
- All yielding code now uses promises

### Removed

- Client.PlayerBackpack

## 7.0.2 - 2024-03-05

### Changed

- Fix client once again

### Removed

- Frozen client tables; causing issues

## 7.0.1 - 2024-03-05

### Changed

- If something is not a module when using `ImportPackages`, it will be ignored
- Fixes `Framework.Client` issues with frozen tables

## 7.0.0 - 2024-03-03

### Added

- Newly upgraded networking library, with `ContextInterface.Network` API
- Renames older API to fit with new standards

### Changed

- Improves how the network library works with unreliables
- Improves general code
- Fixes bugs within `Canary.Client` **(@DrasticBlink)**
- Changes `Canary.GetFramework` to the just the currently running context

### Removed

- `LuminFramework.CreateAnonymousSignal`
- `ContextInterface.NetworkController`
- `LuminFramework.GetFrameworkShared`
- `LuminFramework.Future`

## 6.2.1 - 2023-12-28

### Added

- Networking type validation

### Changed

- Fixes player gui/backpack properties not updating when player respawns
- Deprecate `Debugger.Debug` and `Debugger.DebugPrefix` functions in favor `Debugger.LogEvent`
- Change prefixes of settings to `FFlag`

## 6.1.1 - 2023-12-08

### Changed

- Improves load time to use milliseconds
- Mainly improves docs
- Cleans up code in a few areas
- Changes how network controller logs are formatted

## 6.1.0 - 2023-12-06

### Added

- Support for reliable/unreliable network controllers

### Changed

- Creating an anonymous signal will no longer log the name as 'nil'
- Network controller names now use identifiers
- Network controller creation now displays reliability type in log
- Adds ability to set a listener on a network controller after being initially set

## 6.0.0 - 2023-11-29

### Added

- Better calculation of startup

### Changed

- Improved internally logged events to be more clear

### Removed

- `source` param from LogEvent to make code more neat

## 6.0.0-rc1 - 2023-11-28

### Added

- Revamped documentation layouts
- Use `.luaurc` file instead of `--!strict`
- Correctly logs when an object is created

### Changed

- General code Changed and bug fixes
- Improved API naming to be more clear
- Improves `LogEvent` performance
- Update internal naming scheme to reflect frontend
- `:BindToInvocation` will now give a type warning if at least 1 value is returned
- Improve `:BindToInvocation` to disallow returning nil/nothing
- Add Framework and Server/Client tags to internal logs

### Removed

- Remove deprecated alias `LuminFramework.GetFrameworkReplicated`

## 5.1.0 - 2023-11-21

### Added

- Revamped plugin, now only creates scripts

### Changed

- Refined installation process, makes models available only per release.

## 5.0.0 - 2023-11-08

### Added

- Wally support / Rojo
- Improved documentation
- Adds `ShowLoggedEvents` setting

### Changed

- Mainly lots of internal Changed and/or optimizations
- Optimized `Debugger.LogEvent` in most cases
- Improves debugger user API
- Framework debugs server and client start time in MS
- Removes need for plugin, can drag/drop anywhere

### Removed

- A lot of useless/deprecated functions or properties

## 4.0.0 - 2023-10-14

(Includes rc1-3)

### Added

- Improved API

### Changed

- Improves structure and others
- Improves internal code to be a lot faster
- LuminFramework is now a standalone modulescript which can be used from anywhere

## 4.0.0-rc3 - Unknown

### Added

- Rewrote plugin features
- Add package manager to plugin
- Add ability to add custom packages to manager
- Add `Snacky` to Canary Suite

### Changed

- Improves internal API, should be significantly faster
- Improves networking / signal APIs, tuples are now allowed
- Improves default structure, changed names of all folders to fit developers' needs
- Improve UIShelf, adds text icons + improved menus

### Removed

- Deprecated functions

## 4.0.0-rc2 - Unknown

### Added

- Adds `Red`, revamped the networking system once again and for the last time
- Adds `NetworkController:FireFilter`
- Adds `LuminFramework.ImportPackagesInOrder`2
- Finish API documentation

### Changed

- Adds event logs when creating classes
- Creating new scripts / packages will now have the date when created, and your username at top (thanks @BigBubba!)
- Changes structure to be more efficient
- Signals / NetworkControllers allow tuples
- Small bug fixes
- QOL fixes

### Removed

- `BridgeNet`

## 4.0.0-rc1 - Unknown

### Added

- Revamped plugin for last time, easier to navigate / add features
- Adds ability to pull packages from any GitHub repo
- Entirely new documentation provider

### Changed

- Improves EasyProfile ([#3](https://github.com/canary-development/LuminFramework/pull/3), [koxx12](https://github.com/koxx12-dev))
- Renames `CanaryEngineFramework` instance to `Framework`
- Renames `LuminFramework` module to `Init`
- Small bug fixes
- QOL fixes
- Most yielding functions now make usage of Futures

### Removed

- `EngineContext.Packages`
- `EngineContext.Media`

## 3.3.5 - 2023-08-25

### Added

- 2 new debugger functions
- UIShelf library
- Documentation blog page

### Changed

- Improve `networkControllerTimeout`
- Improve API docs
- Improve tutorials, 4 new
- Improve types
- Improve performance

## 3.2.5 - 2023-08-12

No information available, mainly small bug fixes.

## 3.2.4 - 2023-08-07

### Added

- `AnonymousSignals` ([#2](https://github.com/canary-development/LuminFramework/pull/2), [koxx12](https://github.com/koxx12-dev))
- `EngineReplicatedFirst`
- Add new default loading screen

### Changed

- Fix all plugin bugs, now runs faster
- Fix signals erroring constantly
- Fix small bugs
- Improve typings
- Updated Benchmark + Debugger modules

## 3.1.4 - 2023-07-22

### Added

- Native `roblox-ts` support
- Docs for all APIs
- Plugin now updates all files dynamically

### Changed

- Improves default structure
- Improved plugin

### Removed

- Remove `Runtime.IsStarted`
- Deprecated `.GetLatestPackageVersionAsync`

## 3.0.1 - Unknown

### Changed

- Typings have been improved to contain an additional argument for network controllers
- Signals now use a wrapper

## 3.0.0 - Unknown

### Added

- Add `LuminFramework.RuntimeCreatedSignals`
- Add `LuminFramework.RuntimeCreatedNetworkControllers`
- Support for invoking server
- Reworked data saving
- Add `CanaryEngineClient.PlayerBackpack`
- Add `Replicated` folder to `LuminFramework/Media`
- Proper documentation to almost all methods, expect finished docs to come along when **v3.1.0** releases with a few hotfixes and general Changed
- Add `CanaryEngineServer.Media.Server`
- Add `CanaryEngineClient.Media.Client`
- Add `Spring` to default packages
- Add `Promise` to default packages
- Add `MatchmakingService`

### Changed

- Turn `NetworkSignal` into `NetworkController`
- Add `signalName` parameter to `LuminFramework.CreateSignal` for easier signal access across scripts (breaking change)
- Add error when trying to import packages during runtime
- Fix `Runtime.IsStarted` not working
- Move `Utility`, `Benchmark`, and `Statistics` to their own each modules for better loading times
- Improve engine context fetch code
- CustomScriptSignal is now ScriptSignal, old ScriptSignal is now BasicScriptSignal
- Improve BridgeNet wrapper to be more clean + efficient
- Internal tooling is extremely easier to access

### Removed

- Remove `CanaryEngineServer.GetDataService`
- Remove `CanaryEngineServer.Media`
- Remove `CanaryEngineClient.Media`

## 2.2.1 - Unknown

### Added

- Add Once + Disconnect to `NetworkSignals`

### Changed

- Fix bugs
- Clean Code
- Framework starts earlier for better server security

## 2.2.0 - Unknown

### Added

- Add 'Statistics Library'
- Add support for EasyDocs
- Add `PlayerGui` to `EngineClient`.

### Changed

- Fix bugs
- Clean Code

## 2.1.0 - Unknown

### Added

- Add Vendor folder under new packages

### Changed

- Make it so that return data from regular `Signal`s return in a table instead of a tuple for consistency
- Create wrapper for BridgeNet instead of editing the source code
- Improve code
- Remove BridgeNet output logs
- Fix support for Wait
- Update `base64` by @Gooncreeper

## 2.0.0 - Unknown

### Added

- Added option to install default packages in the plugin
- Added new `Utility` functions to the module
- Add `base64` by @Gooncreeper
- Add `EngineServer.GetDataService()`
- Add support for debugging in live games

### Changed

- Clean up code
- Bug fixes
- Fix up `random_gen`

### Removed

- Remove `EngineClient.LocalObjects`
- Remove `EngineClient.PreinstalledPackages`
- Remove `EngineServer.PreinstalledPackages`

## 1.2.0 - Unknown

### Added

- Added install and uninstall to plugin
- Added `Utility`, `Benchmark`, and `Serialize` (BlueSerializer by @commitblue) libs to the main module
- Add support for checking framework version automatically with `GetLatestPackageVersionAsync`, it is now an attribute under the main module.
- Better `NetworkSignal` typing

### Changed

- A few QOL fixes
- Bug fixes

### Removed

- Removed intellisense from plugin, it's sadly impossible

## 1.1.0 - Unknown

- Public release! 🥳

[unreleased]: https://github.com/lumin-org/framework/compare/v11.0.0...HEAD
[11.0.0]: https://github.com/lumin-org/framework/compare/v10.0.0...v11.0.0
[10.0.0]: https://github.com/lumin-org/framework/compare/v10.0.0-rc5...v10.0.0
[10.0.0-rc5]: https://github.com/lumin-org/framework/compare/v10.0.0-rc4...v10.0.0-rc5
[10.0.0-rc4]: https://github.com/lumin-org/framework/compare/v10.0.0-rc3...v10.0.0-rc4
[10.0.0-rc3]: https://github.com/lumin-org/framework/compare/v10.0.0-rc2...v10.0.0-rc3
[10.0.0-rc2]: https://github.com/lumin-org/framework/compare/v10.0.0-rc1...v10.0.0-rc2
[10.0.0-rc1]: https://github.com/lumin-org/framework/compare/v9.1.1...v10.0.0-rc1
[9.1.1]: https://github.com/lumin-org/framework/compare/v9.0.1...v9.1.1
[9.0.1]: https://github.com/luminlabsdev/framework/compare/v9.0.0...v9.0.1
[9.0.0]: https://github.com/luminlabsdev/framework/compare/v9.0.0-rc13...v9.0.0
[9.0.0-rc13]: https://github.com/luminlabsdev/framework/compare/v9.0.0-rc12...v9.0.0-rc13
[9.0.0-rc12]: https://github.com/luminlabsdev/framework/compare/v9.0.0-rc11...v9.0.0-rc12
[9.0.0-rc11]: https://github.com/luminlabsdev/framework/compare/v9.0.0-rc10...v9.0.0-rc11
[9.0.0-rc10]: https://github.com/luminlabsdev/framework/compare/v9.0.0-rc9...v9.0.0-rc10
[9.0.0-rc9]: https://github.com/luminlabsdev/framework/compare/v9.0.0-rc8...v9.0.0-rc9
[9.0.0-rc8]: https://github.com/luminlabsdev/framework/compare/v9.0.0-rc7...v9.0.0-rc8
[9.0.0-rc7]: https://github.com/luminlabsdev/framework/compare/v9.0.0-rc6...v9.0.0-rc7
[9.0.0-rc6]: https://github.com/luminlabsdev/framework/compare/v9.0.0-rc6...v9.0.0-rc6
[9.0.0-rc6]: https://github.com/luminlabsdev/framework/compare/v9.0.0-rc5...v9.0.0-rc6
[9.0.0-rc5]: https://github.com/luminlabsdev/framework/compare/v9.0.0-rc4...v9.0.0-rc5
[9.0.0-rc4]: https://github.com/luminlabsdev/framework/compare/v9.0.0-rc3...v9.0.0-rc4
[9.0.0-rc3]: https://github.com/luminlabsdev/framework/compare/v9.0.0-rc2...v9.0.0-rc3
[9.0.0-rc2]: https://github.com/luminlabsdev/framework/compare/v9.0.0-rc1...v9.0.0-rc2
[9.0.0-rc1]: https://github.com/luminlabsdev/framework/compare/v8.1.5...v9.0.0-rc1
