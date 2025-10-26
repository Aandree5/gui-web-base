# Changelog

## [1.6.0](https://github.com/Aandree5/gui-web-base/compare/v1.5.6...v1.6.0) (2025-10-26)


### Features

* updated debian to `trixie` ([#69](https://github.com/Aandree5/gui-web-base/issues/69)) ([b5c9461](https://github.com/Aandree5/gui-web-base/commit/b5c9461641b117bbfe3ceea18f30f510a2029483))

## [1.5.6](https://github.com/Aandree5/gui-web-base/compare/v1.5.5...v1.5.6) (2025-10-24)


### Bug Fixes

* moved to nginx to fix SSL auth prompt ([c2e655a](https://github.com/Aandree5/gui-web-base/commit/c2e655a9d2eed8ddb432728c519806cdae3c9198))
* moved to nginx to fix SSL auth prompt ([#67](https://github.com/Aandree5/gui-web-base/issues/67)) ([c2e655a](https://github.com/Aandree5/gui-web-base/commit/c2e655a9d2eed8ddb432728c519806cdae3c9198))

## [1.5.5](https://github.com/Aandree5/gui-web-base/compare/v1.5.4...v1.5.5) (2025-10-24)


### Bug Fixes

* removed `SSL_CET_PATH` in favour of `ENABLE_SSL` workflow ([#64](https://github.com/Aandree5/gui-web-base/issues/64)) ([3092d4b](https://github.com/Aandree5/gui-web-base/commit/3092d4b0f6fbb4e71eeb756c1145ea5325f0ff9e))

## [1.5.4](https://github.com/Aandree5/gui-web-base/compare/v1.5.3...v1.5.4) (2025-10-23)


### Bug Fixes

* moved ssl certificate generation logic to runtime ([#61](https://github.com/Aandree5/gui-web-base/issues/61)) ([8c9f58f](https://github.com/Aandree5/gui-web-base/commit/8c9f58f1196131685d9ab5115e843103666e5b24))

## [1.5.3](https://github.com/Aandree5/gui-web-base/compare/v1.5.2...v1.5.3) (2025-10-22)


### Bug Fixes

* added self-signed certificate for https ([#60](https://github.com/Aandree5/gui-web-base/issues/60)) ([890bcb0](https://github.com/Aandree5/gui-web-base/commit/890bcb0ad2868f43fd00ea550c07f9d14200f92b))
* 

## [1.5.2](https://github.com/Aandree5/gui-web-base/compare/v1.5.1...v1.5.2) (2025-10-22)


### Bug Fixes

* `APPS_DIRS` overriding downstream image values ([#57](https://github.com/Aandree5/gui-web-base/issues/57)) ([9d1db93](https://github.com/Aandree5/gui-web-base/commit/9d1db93e95db4cc5c863de350c2f1cbf83b78857))

## [1.5.1](https://github.com/Aandree5/gui-web-base/compare/v1.5.0...v1.5.1) (2025-10-22)


### Bug Fixes

* corrected permissions flow ([#55](https://github.com/Aandree5/gui-web-base/issues/55)) ([25a8bd0](https://github.com/Aandree5/gui-web-base/commit/25a8bd0847c975c4a50c9eaa82db8c1e48f688b7))

## [1.5.0](https://github.com/Aandree5/gui-web-base/compare/v1.4.0...v1.5.0) (2025-10-21)


### Features

* added functionality to get runtime user home dir on downstream … ([#53](https://github.com/Aandree5/gui-web-base/issues/53)) ([4b3b3f9](https://github.com/Aandree5/gui-web-base/commit/4b3b3f9919b98f1535d687eb31a32a07d4e0b6c1))

## [1.4.0](https://github.com/Aandree5/gui-web-base/compare/v1.3.1...v1.4.0) (2025-10-21)


### Features

* added application directories functionality ([#50](https://github.com/Aandree5/gui-web-base/issues/50)) ([05bc921](https://github.com/Aandree5/gui-web-base/commit/05bc92136e0a44a75dcb25982a4a918cf79603aa))

## [1.3.1](https://github.com/Aandree5/gui-web-base/compare/v1.3.0...v1.3.1) (2025-10-20)


### Bug Fixes

* non-root user flow ([#43](https://github.com/Aandree5/gui-web-base/issues/43)) ([c0ad910](https://github.com/Aandree5/gui-web-base/commit/c0ad910ab6b3c9bc4f9fa42566a412f396de404e))

## [1.3.0](https://github.com/Aandree5/gui-web-base/compare/v1.2.1...v1.3.0) (2025-10-20)


### Features

* upgrade xpra to install from their repo ([#40](https://github.com/Aandree5/gui-web-base/issues/40)) ([c491024](https://github.com/Aandree5/gui-web-base/commit/c49102408c3b5d70084a7a7e6916424296717d9b))

## [1.2.1](https://github.com/Aandree5/gui-web-base/compare/v1.2.0...v1.2.1) (2025-10-18)


### Bug Fixes

* removed customisation as it breaches upstream license ([#36](https://github.com/Aandree5/gui-web-base/issues/36)) ([91408d2](https://github.com/Aandree5/gui-web-base/commit/91408d28e9af2a5c0727465aa6bbf9a964b6401c))

## [1.2.0](https://github.com/Aandree5/gui-web-base/compare/v1.1.2...v1.2.0) (2025-10-17)


### Features

* configure favicon ([ca7cd29](https://github.com/Aandree5/gui-web-base/commit/ca7cd2943199c01e4f6d0ce3192965d0cd6b77de))
* favicon configuration ([#33](https://github.com/Aandree5/gui-web-base/issues/33)) ([ca7cd29](https://github.com/Aandree5/gui-web-base/commit/ca7cd2943199c01e4f6d0ce3192965d0cd6b77de))

## [1.1.2](https://github.com/Aandree5/gui-web-base/compare/v1.1.1...v1.1.2) (2025-10-17)


### Bug Fixes

* default webpage title not working ([#31](https://github.com/Aandree5/gui-web-base/issues/31)) ([8082510](https://github.com/Aandree5/gui-web-base/commit/8082510c813473a291e0a8e622cd971fe435d39f))

## [1.1.1](https://github.com/Aandree5/gui-web-base/compare/v1.1.0...v1.1.1) (2025-10-15)


### Bug Fixes

* url too long ([#15](https://github.com/Aandree5/gui-web-base/issues/15)) ([c256e8c](https://github.com/Aandree5/gui-web-base/commit/c256e8ceecb2f5bd222d6f0c5c38a39d6019f989))

## [1.1.0](https://github.com/Aandree5/gui-web-base/compare/v1.0.0...v1.1.0) (2025-10-15)


### Features

* add webpage title override ([0b2f0b5](https://github.com/Aandree5/gui-web-base/commit/0b2f0b5cf0795774110fb1550c89180216e7948b))
* added release please workflow ([d3ade76](https://github.com/Aandree5/gui-web-base/commit/d3ade76b6d640b36e729f34d5f5626b91ed0657a))


### Bug Fixes

* add token to workflow ([#5](https://github.com/Aandree5/gui-web-base/issues/5)) ([56f5740](https://github.com/Aandree5/gui-web-base/commit/56f5740baf4464bdb73e21d963336849ece5cd18))
* added missing manifest file ([#7](https://github.com/Aandree5/gui-web-base/issues/7)) ([dbe7d1e](https://github.com/Aandree5/gui-web-base/commit/dbe7d1e2611b280e43f392e995d0b81e5912fd34))
* app watchdog ([6330e1a](https://github.com/Aandree5/gui-web-base/commit/6330e1abf33b5bbcaad0aea53717a90cf0f2715f))
* app watchdog ([7e533c9](https://github.com/Aandree5/gui-web-base/commit/7e533c94a2ce8dce2298dcae2e9ff39dd2d0bef0))
* app watchdog monitor ([3a0e242](https://github.com/Aandree5/gui-web-base/commit/3a0e2420c28221bef186ee2f15a4877e255a91c4))
* entrypoint file path ([7d28bc3](https://github.com/Aandree5/gui-web-base/commit/7d28bc312e611c081cd0df25b160026af9d8074d))
* file line ending to LF ([fb20afa](https://github.com/Aandree5/gui-web-base/commit/fb20afa36d059811c71ceba06944531578b54d08))
* release please config ([#10](https://github.com/Aandree5/gui-web-base/issues/10)) ([5e8eeb6](https://github.com/Aandree5/gui-web-base/commit/5e8eeb6f4f2f62beefd2f9c778173cebf7e3eac1))
* release please config file ([#6](https://github.com/Aandree5/gui-web-base/issues/6)) ([7479b8c](https://github.com/Aandree5/gui-web-base/commit/7479b8c25378100aaeb9dc528fa6afa8834b2ba9))
* release please config package type ([#9](https://github.com/Aandree5/gui-web-base/issues/9)) ([eeb9280](https://github.com/Aandree5/gui-web-base/commit/eeb92802934f48e868b91e47dc2f26343fad56a8))
* release please configs ([#8](https://github.com/Aandree5/gui-web-base/issues/8)) ([54a2c70](https://github.com/Aandree5/gui-web-base/commit/54a2c705fcaec2c269c15d0746cb8199d76d4a99))
* release please issues ([6d1f090](https://github.com/Aandree5/gui-web-base/commit/6d1f09099e1a5b1f652773b77495f79bd5656951))
* release please tagging ([#12](https://github.com/Aandree5/gui-web-base/issues/12)) ([8216725](https://github.com/Aandree5/gui-web-base/commit/8216725dbe86ef5493566a990a80a736887c326e))
* release please type ([#1](https://github.com/Aandree5/gui-web-base/issues/1)) ([270b4f7](https://github.com/Aandree5/gui-web-base/commit/270b4f7aed159a32ae6d68e6cbd18db863650bcd))
* workflow job version ([513a757](https://github.com/Aandree5/gui-web-base/commit/513a757e2cd020e45b36a34c59169d2ed803d063))
* workflow secret name ([f58a111](https://github.com/Aandree5/gui-web-base/commit/f58a111cd81cd0d376dcab7f4130a32a72ea56b0))

## 1.0.0 (2025-10-15)


### Features

* add webpage title override ([0b2f0b5](https://github.com/Aandree5/gui-web-base/commit/0b2f0b5cf0795774110fb1550c89180216e7948b))
* added release please workflow ([d3ade76](https://github.com/Aandree5/gui-web-base/commit/d3ade76b6d640b36e729f34d5f5626b91ed0657a))


### Bug Fixes

* add token to workflow ([#5](https://github.com/Aandree5/gui-web-base/issues/5)) ([56f5740](https://github.com/Aandree5/gui-web-base/commit/56f5740baf4464bdb73e21d963336849ece5cd18))
* added missing manifest file ([#7](https://github.com/Aandree5/gui-web-base/issues/7)) ([dbe7d1e](https://github.com/Aandree5/gui-web-base/commit/dbe7d1e2611b280e43f392e995d0b81e5912fd34))
* app watchdog ([6330e1a](https://github.com/Aandree5/gui-web-base/commit/6330e1abf33b5bbcaad0aea53717a90cf0f2715f))
* app watchdog ([7e533c9](https://github.com/Aandree5/gui-web-base/commit/7e533c94a2ce8dce2298dcae2e9ff39dd2d0bef0))
* app watchdog monitor ([3a0e242](https://github.com/Aandree5/gui-web-base/commit/3a0e2420c28221bef186ee2f15a4877e255a91c4))
* entrypoint file path ([7d28bc3](https://github.com/Aandree5/gui-web-base/commit/7d28bc312e611c081cd0df25b160026af9d8074d))
* file line ending to LF ([fb20afa](https://github.com/Aandree5/gui-web-base/commit/fb20afa36d059811c71ceba06944531578b54d08))
* release please config ([#10](https://github.com/Aandree5/gui-web-base/issues/10)) ([5e8eeb6](https://github.com/Aandree5/gui-web-base/commit/5e8eeb6f4f2f62beefd2f9c778173cebf7e3eac1))
* release please config file ([#6](https://github.com/Aandree5/gui-web-base/issues/6)) ([7479b8c](https://github.com/Aandree5/gui-web-base/commit/7479b8c25378100aaeb9dc528fa6afa8834b2ba9))
* release please config package type ([#9](https://github.com/Aandree5/gui-web-base/issues/9)) ([eeb9280](https://github.com/Aandree5/gui-web-base/commit/eeb92802934f48e868b91e47dc2f26343fad56a8))
* release please configs ([#8](https://github.com/Aandree5/gui-web-base/issues/8)) ([54a2c70](https://github.com/Aandree5/gui-web-base/commit/54a2c705fcaec2c269c15d0746cb8199d76d4a99))
* release please issues ([6d1f090](https://github.com/Aandree5/gui-web-base/commit/6d1f09099e1a5b1f652773b77495f79bd5656951))
* release please type ([#1](https://github.com/Aandree5/gui-web-base/issues/1)) ([270b4f7](https://github.com/Aandree5/gui-web-base/commit/270b4f7aed159a32ae6d68e6cbd18db863650bcd))
* workflow job version ([513a757](https://github.com/Aandree5/gui-web-base/commit/513a757e2cd020e45b36a34c59169d2ed803d063))
* workflow secret name ([f58a111](https://github.com/Aandree5/gui-web-base/commit/f58a111cd81cd0d376dcab7f4130a32a72ea56b0))

## [0.2.0](https://github.com/Aandree5/gui-web-base/compare/v0.1.0...v0.2.0) (2025-10-15)


### Features

* added release please workflow ([d3ade76](https://github.com/Aandree5/gui-web-base/commit/d3ade76b6d640b36e729f34d5f5626b91ed0657a))


### Bug Fixes

* release please type ([#1](https://github.com/Aandree5/gui-web-base/issues/1)) ([270b4f7](https://github.com/Aandree5/gui-web-base/commit/270b4f7aed159a32ae6d68e6cbd18db863650bcd))
