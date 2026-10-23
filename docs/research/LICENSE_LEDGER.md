# License Adoption Ledger

## Status and decision boundary

This ledger is a mandatory adoption gate for code, SDKs, dependencies, DSP, samples, fonts, icons, patches, instruments, and other content.
It records documentary evidence available to R07 on 2026-10-23.
It does not approve an item, select an architecture, give legal advice, or authorize acquisition, installation, build, bundling, distribution, account acceptance, or release.
Every item remains **Not approved**.
Public availability, repository visibility, a local cache, a lockfile entry, successful installation, or readable terms do not establish permission for the intended product and distribution scenario.

`Unassessed` and `Not approved` are workflow states rather than license conclusions.
A future status change requires an exact candidate, selected build and distribution scenario, authoritative evidence, qualified review where required, and an owner decision recorded in a separate authorized task.
The app is still an M0 Flutter shell; no audio, MIDI, plugin host, sound engine, piano, factory content, patch, or distribution capability is implemented or approved.

## Evidence boundary

- Canonical source URLs, access timestamps, complete SHA-256 values, request results, local paths, and reused-source provenance are in the [R07 source register](../orchestration/milestones/m0/evidence/r07-sources.md).
- R07 used five public request indexes: 78 requests, 77 HTTP 200 bodies, and one retained HTTP 403 failure for JUCE commercial terms (P75).
- Two local indexes contain 56 existing metadata or license bodies; 25 earlier public bodies were reused with their original R04, R05, or R06 provenance.
- The source date for new R07 public and local observations is 2026-10-23; reused records retain their original timestamps in the canonical register.
- All 23 hosted package metadata versions and archive hashes match the committed lock values, and their published license bodies match the cached license bodies after edge-whitespace trim.
- Those matches do not authenticate downloaded archives or every cached byte, prove a shipping graph, or clear distribution.
- No package archive, source archive, sample, SoundFont, MIDI asset, patch, font binary, or other content binary was downloaded or inspected for R07.
- Raw source bodies remain outside the repository in the controller evidence directory; this ledger paraphrases them and links the immutable register.
- Reading public terms did not accept an agreement or establish which account-specific terms or schedules apply.

## Interpretation labels

- **Fact** means a statement directly supported by a cited body or committed metadata.
- **Inference** means a bounded implication drawn from facts and is not a legal conclusion.
- **Recommendation** means a proposed future evidence step and is unperformed.
- **Gap** means evidence or a scenario needed before a decision.
- **Owner decision** means a later human gate; this document does not exercise it.

## Existing foundation SDK and tool surfaces

| Item | Exact identity and intended use | Evidence and source-qualified observation | Conditions, gaps, and risk | Reviewer/date/status |
| --- | --- | --- | --- | --- |
| Flutter SDK | Local Flutter 3.44.8; framework `058e0af2c2b57e369d905a03ac9748b0ebf543c6`; app framework/tooling | P01 official pinned `LICENSE` and L03/L04 local metadata/text; BSD-3-Clause-style grant | Retain copyright, conditions, disclaimer; no endorsement. Root license is not a complete engine, vendor, artifact, or platform inventory. | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| Dart SDK | Local bundled Dart 3.12.2; revision `d684a576a6aa954ae107a03b2b4e1d61c3bebe93`; language/build tooling | P02 commit mapping, P03 tag license, P62 exact revision license, L05/L06 local version/text; BSD-3-Clause-style grant | Retain copyright, conditions, disclaimer; no endorsement. Selected release and shipped components remain future build evidence. | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| Flutter SDK packages | `flutter`, `flutter_test`, `sky_engine`; lock labels each `0.0.0`; framework/test/engine SDK surfaces | L01/L02 committed manifest and lock | `0.0.0` is an SDK lock label, not a public release version. Exact shipped SDK graph and notices remain unselected. | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| Loop process tool | `@cobusgreyling/loop` 0.2.0; repository commit `3f7ac78c4d1fd6e363b3b1e592a44fd4cc4161a8`; manual process initializer/doctor/cost tooling | P04 registry metadata, P61 tree, P68 MIT root, P69 package metadata | MIT notice must accompany covered copies. The foundation records this as the `process_loop` 0.2.0 process use; it does not put the package in the app bundle. No archive was fetched and the distribution graph is not established. | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| Material icon/font surface | Existing `uses-material-design: true`; UI asset surface | L01 manifest; L53 metadata; L54 Material Icons CC BY 4.0; L55/L56 Roboto and Roboto Condensed Apache-2.0 text | CC attribution differs from Apache notice/change duties. No font binary or exact shipped artifact was authenticated, and the future release contents are unknown. | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| Generated Android/iOS hosts | Existing foundation host scaffolds; platform integration | Committed foundation plus public platform terms P09/P73 | SDK, signing, store, account, privacy, and distribution scenario are unselected. Native API documentation is not a blanket redistribution license. | Licensing/Security + owner / 2026-10-23 / **Not approved** |

### Locked hosted package inventory

The package rows below cover every hosted entry in the committed `pubspec.lock`.
Registry IDs P14–P36 bind exact version metadata and archive hashes; P37–P59 bind version-specific published license pages.
The matching L07–L52 bodies bind cached license and package metadata.
`clock`, `fake_async`, and `material_color_utilities` carry Apache-2.0 text; the other 20 carry BSD-3-Clause-style text.
Use classifications describe the current resolved foundation graph and do not decide which packages enter a future shipped artifact.

| Package | Exact version and lock/archive SHA-256 | Sources; current use class | License observation and duties | Reviewer/date/status |
| --- | --- | --- | --- | --- |
| `async` | 2.13.1; `e2eb0491ba5ddb6177742d2da23904574082139b07c1e33b8503b9f46f3e1a37` | [P14](https://pub.dev/api/packages/async/versions/2.13.1)/[P37](https://pub.dev/packages/async/versions/2.13.1/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `boolean_selector` | 2.1.2; `8aab1771e1243a5063b8b0ff68042d67334e3feab9e95b9490f9a6ebf73b42ea` | [P15](https://pub.dev/api/packages/boolean_selector/versions/2.1.2)/[P38](https://pub.dev/packages/boolean_selector/versions/2.1.2/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `characters` | 1.4.1; `faf38497bda5ead2a8c7615f4f7939df04333478bf32e4173fcb06d428b5716b` | [P16](https://pub.dev/api/packages/characters/versions/1.4.1)/[P39](https://pub.dev/packages/characters/versions/1.4.1/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `clock` | 1.1.2; `fddb70d9b5277016c77a80201021d40a2247104d9f4aa7bab7157b7e3f05b84b` | [P17](https://pub.dev/api/packages/clock/versions/1.1.2)/[P40](https://pub.dev/packages/clock/versions/1.1.2/license); resolved transitive development/test/tooling graph | Apache-2.0; retain license and notices; mark changes; patent and trademark terms apply where triggered; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `collection` | 1.19.1; `2f5709ae4d3d59dd8f7cd309b4e023046b57d8a6c82130785d2b0e5868084e76` | [P18](https://pub.dev/api/packages/collection/versions/1.19.1)/[P41](https://pub.dev/packages/collection/versions/1.19.1/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `fake_async` | 1.3.3; `5368f224a74523e8d2e7399ea1638b37aecfca824a3cc4dfdf77bf1fa905ac44` | [P19](https://pub.dev/api/packages/fake_async/versions/1.3.3)/[P42](https://pub.dev/packages/fake_async/versions/1.3.3/license); resolved transitive development/test/tooling graph | Apache-2.0; retain license and notices; mark changes; patent and trademark terms apply where triggered; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `flutter_lints` | 6.0.0; `3105dc8492f6183fb076ccf1f351ac3d60564bff92e20bfc4af9cc1651f4e7e1` | [P20](https://pub.dev/api/packages/flutter_lints/versions/6.0.0)/[P43](https://pub.dev/packages/flutter_lints/versions/6.0.0/license); direct dev lint configuration | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `leak_tracker` | 11.0.2; `33e2e26bdd85a0112ec15400c8cbffea70d0f9c3407491f672a2fad47915e2de` | [P21](https://pub.dev/api/packages/leak_tracker/versions/11.0.2)/[P44](https://pub.dev/packages/leak_tracker/versions/11.0.2/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `leak_tracker_flutter_testing` | 3.0.10; `1dbc140bb5a23c75ea9c4811222756104fbcd1a27173f0c34ca01e16bea473c1` | [P22](https://pub.dev/api/packages/leak_tracker_flutter_testing/versions/3.0.10)/[P45](https://pub.dev/packages/leak_tracker_flutter_testing/versions/3.0.10/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `leak_tracker_testing` | 3.0.2; `8d5a2d49f4a66b49744b23b018848400d23e54caf9463f4eb20df3eb8acb2eb1` | [P23](https://pub.dev/api/packages/leak_tracker_testing/versions/3.0.2)/[P46](https://pub.dev/packages/leak_tracker_testing/versions/3.0.2/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `lints` | 6.1.0; `12f842a479589fea194fe5c5a3095abc7be0c1f2ddfa9a0e76aed1dbd26a87df` | [P24](https://pub.dev/api/packages/lints/versions/6.1.0)/[P47](https://pub.dev/packages/lints/versions/6.1.0/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `matcher` | 0.12.19; `dc0b7dc7651697ea4ff3e69ef44b0407ea32c487a39fff6a4004fa585e901861` | [P25](https://pub.dev/api/packages/matcher/versions/0.12.19)/[P48](https://pub.dev/packages/matcher/versions/0.12.19/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `material_color_utilities` | 0.13.0; `9c337007e82b1889149c82ed242ed1cb24a66044e30979c44912381e9be4c48b` | [P26](https://pub.dev/api/packages/material_color_utilities/versions/0.13.0)/[P49](https://pub.dev/packages/material_color_utilities/versions/0.13.0/license); resolved transitive development/test/tooling graph | Apache-2.0; retain license and notices; mark changes; patent and trademark terms apply where triggered; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `meta` | 1.18.0; `1741988757a65eb6b36abe716829688cf01910bbf91c34354ff7ec1c3de2b349` | [P27](https://pub.dev/api/packages/meta/versions/1.18.0)/[P50](https://pub.dev/packages/meta/versions/1.18.0/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `path` | 1.9.1; `75cca69d1490965be98c73ceaea117e8a04dd21217b37b292c9ddbec0d955bc5` | [P28](https://pub.dev/api/packages/path/versions/1.9.1)/[P51](https://pub.dev/packages/path/versions/1.9.1/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `source_span` | 1.10.2; `56a02f1f4cd1a2d96303c0144c93bd6d909eea6bee6bf5a0e0b685edbd4c47ab` | [P29](https://pub.dev/api/packages/source_span/versions/1.10.2)/[P52](https://pub.dev/packages/source_span/versions/1.10.2/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `stack_trace` | 1.12.1; `8b27215b45d22309b5cddda1aa2b19bdfec9df0e765f2de506401c071d38d1b1` | [P30](https://pub.dev/api/packages/stack_trace/versions/1.12.1)/[P53](https://pub.dev/packages/stack_trace/versions/1.12.1/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `stream_channel` | 2.1.4; `969e04c80b8bcdf826f8f16579c7b14d780458bd97f56d107d3950fdbeef059d` | [P31](https://pub.dev/api/packages/stream_channel/versions/2.1.4)/[P54](https://pub.dev/packages/stream_channel/versions/2.1.4/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `string_scanner` | 1.4.1; `921cd31725b72fe181906c6a94d987c78e3b98c2e205b397ea399d4054872b43` | [P32](https://pub.dev/api/packages/string_scanner/versions/1.4.1)/[P55](https://pub.dev/packages/string_scanner/versions/1.4.1/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `term_glyph` | 1.2.2; `7f554798625ea768a7518313e58f83891c7f5024f88e46e7182a4558850a4b8e` | [P33](https://pub.dev/api/packages/term_glyph/versions/1.2.2)/[P56](https://pub.dev/packages/term_glyph/versions/1.2.2/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `test_api` | 0.7.11; `949a932224383300f01be9221c39180316445ecb8e7547f70a41a35bf421fb9e` | [P34](https://pub.dev/api/packages/test_api/versions/0.7.11)/[P57](https://pub.dev/packages/test_api/versions/0.7.11/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `vector_math` | 2.2.0; `d530bd74fea330e6e364cda7a85019c434070188383e1cd8d9777ee586914c5b` | [P35](https://pub.dev/api/packages/vector_math/versions/2.2.0)/[P58](https://pub.dev/packages/vector_math/versions/2.2.0/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| `vm_service` | 15.3.0; `5f37239c4851efcef929cea7824e76df7f2f0970aef85d66bbc430afa40e72f0` | [P36](https://pub.dev/api/packages/vm_service/versions/15.3.0)/[P59](https://pub.dev/packages/vm_service/versions/15.3.0/license); resolved transitive development/test/tooling graph | BSD-3-Clause-style; retain copyright, conditions, disclaimer; no endorsement; artifact contents/shipping role still unverified | Licensing/Security + owner / 2026-10-23 / **Not approved** |


Package reconciliation facts:

- **Fact:** all 23 registry versions equal the lock versions.
- **Fact:** all 23 registry `archive_sha256` values equal the committed lock SHA-256 values.
- **Fact:** all 23 published license extracts equal the corresponding cached license after trimming only outer whitespace.
- **Gap:** R07 did not download or authenticate archives, enumerate every file and notice within them, or produce a release bill of materials.
- **Gap:** development-only versus shipped status must be proved from a future selected build and distribution artifact.
- **Recommendation:** regenerate this table from the exact future lock and artifact graph before release review.
- **Owner decision:** approve or reject the resulting exact distribution set after qualified review; no package is approved here.

### Preserved unselected classes

These generic gates from the original ledger remain in force alongside the item-specific rows.

| Unselected class | Current state and evidence needed | Reviewer/date/status |
| --- | --- | --- |
| Future code dependencies | No additional candidate/version is selected; exact source, graph, license, notices, build, and distribution evidence required | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| Future DSP code | No additional source/version is selected; exact implementation provenance, embedded code, patent/trademark, build, and distribution evidence required | Qualified review + owner / 2026-10-23 / **Not approved** |
| Future audio samples | No sample set or provenance is selected; recording, performer/composition where applicable, modification, commercial, redistribution, and export rights required | Qualified review + owner / 2026-10-23 / **Not approved** |
| Future fonts/icons | No custom asset is selected; exact family/version/binary, creator/source, embedding, attribution, modification, and distribution evidence required | Qualified review + owner / 2026-10-23 / **Not approved** |
| Future instrument/patch content | No instrument, preset, patch, or factory content is selected; constituent-source, author, metadata, name, distribution, derivative, and export rights required | Qualified review + owner / 2026-10-23 / **Not approved** |

## Materially investigated code and hosting candidates

| Candidate | Exact identity and hypothetical use | Evidence and positive license facts | Configuration, distribution, and evidence gaps | Reviewer/date/status |
| --- | --- | --- | --- | --- |
| UAPMD | 0.5.6 = `93c25a7093967efb9d10787239248e74204ac927`; possible plugin-host research candidate | P05/P06 release identity; P60 tree; P63 MIT root; P64 Apache-2.0 body; P65 README; P66/P67 submodule declarations | P65 describes Apache `uapmd-ara` and MIT remainder, with known ISC, MIT, BSD, Zlib, WTFPL, Apache, OFL, CC-BY, plugin, JS, MCP, font, model, and optional/transitive surfaces. Exact selected build and complete graph are unknown. | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| UAPMD ARA branch | Same 0.5.6 pin; optional application integration | P06 says `-DUAPMD_ENABLE_ARA` has an application-level Apache-2.0 effect and also describes runtime enable/disable | The maintainer wording leaves a configuration interpretation question; it is not a legal conclusion. No ARA SDK, terms, feature, or distribution branch is selected. | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| AAP core | `682e7a6871a6c1414619dc483c1e234cb44e3ec3`; possible Android plugin boundary | R04-C22/C23/C24; MIT root | Known family risks include zix/choc ISC, ayumi MIT, Oboe and webaudio-controls Apache-2.0. Root MIT does not clear imported components, generated files, apps, services, or a selected build. | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| AAP-JUCE | `07b99087c3675b7fa41c0bae61525d8d0bc4b3d4`; possible bridge | R04-C25/C26/C27; repository states AGPLv3, with full AGPL body captured | Exact JUCE version, patches, generated or linked portions, Android packaging, and source/network obligations need selected-build analysis. | Qualified review + owner / 2026-10-23 / **Not approved** |
| JUCE | R02 content pin `7aae7d8e8deb8413bb01633d2795ef9974a181c5`; possible engine/plugin framework | P11 tree, P70 license: AGPLv3 or a commercial JUCE license; examples described as ISC; P74 SPDX inventory | SPDX inventory is not the app graph. JUCE v9 commercial terms P75 returned HTTP 403, so rights, price, and applicable terms are unknown. No license branch is chosen. | Qualified review + owner / 2026-10-23 / **Not approved** |
| Oboe | `4468344c8fdfdd7df068d5abefe2d8615fd6b431`; possible Android audio wrapper | R04-C19/C20/C21; Apache-2.0 | Retain license/notices and mark changes where required; exact selected native graph, ABI, SDK/NDK terms, notices, and artifact remain unknown. | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| CPAL | R02 candidate `e1612d5d98152f8dc2a62e1b51ef7cbf4f7f26b7`; README identified v0.18.2; possible cross-platform audio wrapper | P12 tree and P71 Apache-2.0 body | Root license does not enumerate the resolved Cargo feature graph or mobile platform backends. No crate set or target is selected. | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| miniaudio | R02 candidate `9634bedb5b5a2ca38c1ee7108a9358a4e233f14d`; README identified 0.11.25; possible audio wrapper | P13 tree and P72 alternatives: public domain dedication or MIT | A future user must choose and document the applicable alternative and exact configuration. Bundled backends, notices, source, and platform graph are unselected. | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| Apple audio/AUv3/Core MIDI APIs | Official Apple API research from R03/R05; possible native integration | Technical documents establish API behavior and availability only; P07 links terms and P73 captures the public Xcode/Apple SDK agreement | API documentation does not grant blanket redistribution rights. Xcode, SDK, Developer Program, App Store, signing, entitlement, third-party AU, and content terms remain scenario-specific. | Qualified review + owner / 2026-10-23 / **Not approved** |
| Android audio/MIDI/AAP API surfaces | Official Android API research from R04/R05; possible native integration | Technical docs plus P09 Android SDK terms | API docs do not clear SDK/NDK distribution, Play policy, service configuration, external plugins, or content. Target/min SDK and shipped components remain unselected. | Qualified review + owner / 2026-10-23 / **Not approved** |
| MIDI/UMP/MPE documents | R05 M44 UMP v1.1.2 and M46 historical MPE v1.0; protocol research only | Technical specifications were read; original provenance and hashes are in the canonical register | Specification copyright and implementation/content rights are separate. No normative text or diagram is approved for copying, and protocol scope/trademark questions remain. | Qualified review + owner / 2026-10-23 / **Not approved** |

### UAPMD component detail

- **Fact (P63/P65):** the repository identifies the general project remainder as MIT.
- **Fact (P64/P65):** `uapmd-ara` is identified as Apache-2.0.
- **Fact (P06):** release 0.5.6 attributes an application-level Apache-2.0 effect to enabling ARA with `-DUAPMD_ENABLE_ARA`.
- **Gap:** P06 also uses runtime-enable wording; the exact build/runtime relationship requires maintainer clarification and qualified review.
- **Fact (P65):** described component families include ISC, MIT, BSD variants, Zlib, WTFPL, Apache-2.0, OFL, and CC-BY.
- **Fact (P65):** described surfaces also include plugins, JavaScript, MCP, models, and fonts.
- **Fact (P65):** referenced fonts include Roboto under OFL, Font Awesome under CC BY plus OFL, and fontaudio under MIT.
- **Fact:** those UAPMD font identities differ from the Flutter cache evidence in L54–L56.
- **Gap:** source files, submodules, optional flags, generated output, downloaded material, and a complete selected transitive graph have not been reconciled.
- **Gap:** the new full pin is a dated R07 finding and must not be backdated as the exact R02 study pin.
- **Recommendation:** if UAPMD remains a candidate, freeze an exact subset and build configuration before any implementation or adoption request.

## Sound engine and format candidates

| Candidate | Exact identity and hypothetical use | Evidence and positive rights facts | Material branch or content gap | Reviewer/date/status |
| --- | --- | --- | --- | --- |
| FluidSynth | 2.6.1 = `71e85b2ca6bf48641ba7e2261d8f2640ae473773`; possible SoundFont engine | R06-S20 full LGPL-2.1; S21/S22 project/build evidence; S26 historical FAQ | Exact static/dynamic/link method, modifications, enabled components, notices, source/object/relink/replacement materials, SDK/store terms, and selected graph require review. | Qualified review + owner / 2026-10-23 / **Not approved** |
| sfizz | 1.2.3 = `4e70dc0bef53b41f2853ed46e26f5911114c92d0`; possible SFZ engine | R06-S29 root BSD-2-Clause; S30/S31/S44/S45 dependency/configuration evidence | Default dr_libs is MIT-0; optional libsndfile is LGPL-2.1; described families include Apache-2.0, MIT, BSD-2/3, WTFPL-2.0, STK 4.3/permissive LGPL, and Boost. Actual build is unknown. | Qualified review + owner / 2026-10-23 / **Not approved** |
| TinySoundFont | HEAD `853a0a171759f1ddba0de1442133a75912bbeffa`; header states 0.9; possible small SF2 engine | R06-S35 root MIT notice 2017–2023; S37 header MIT notice 2017–2025 and SFZero 2012 notice | No API release exists. Notice years differ and must be preserved. Root MIT does not clear example assets or a future selected SoundFont. | Licensing/Security + owner / 2026-10-23 / **Not approved** |
| TinySoundFont contribution path | Same dated HEAD; upstream interaction only | R06-S36 records a no-LLM contribution policy separately from the code license | The policy does not amend MIT and does not authorize a contribution. No contribution is authorized by this project. | Owner / 2026-10-23 / **Not approved** |
| TinySoundFont examples | `examples/florestan-subset.sf2`, `examples/venture.mid`; excluded reference paths | R06-S16 tree and S36 README identify paths; no bytes inspected | Rights and provenance are unknown. They are excluded from MIT-code inference and from any fixture or product content. | Qualified review + owner / 2026-10-23 / **Not approved** |
| SF2 historical mirror | R06-S42 69-page mirror at `https://www.synthfont.com/sfspec24.pdf`; format research | Mixed observed labels: title v2.04 dated 2006-02-03, revision table 2.04 dated 2002-09-10, footer 2.01/1996 | Original publisher was not retrieved. Formal technical content does not establish copying permission or clear engine, samples, banks, presets, or names. | Qualified review + owner / 2026-10-23 / **Not approved** |
| SFZ references | R06-S19/S43 community material and sfizz status; format research | Community documentation and implementation coverage observations | No normative publisher specification or blanket format rights were established. Referenced samples, paths, metadata, names, and content have separate rights. | Qualified review + owner / 2026-10-23 / **Not approved** |

### Authoritative URL map

All links below were accessed on 2026-10-23 unless the canonical register gives an earlier preserved R04–R06 timestamp.
The [canonical R07 source register](../orchestration/milestones/m0/evidence/r07-sources.md) binds each ID to its complete timestamp, request result, body size, and SHA-256.

| IDs | Exact authoritative or original URL | Evidence role |
| --- | --- | --- |
| P01 | https://raw.githubusercontent.com/flutter/flutter/058e0af2c2b57e369d905a03ac9748b0ebf543c6/LICENSE | Flutter pinned license |
| P02/P62 | https://api.github.com/repos/dart-lang/sdk/commits/3.12.2 and https://raw.githubusercontent.com/dart-lang/sdk/d684a576a6aa954ae107a03b2b4e1d61c3bebe93/LICENSE | Dart release mapping and pinned license |
| P04/P68/P69 | https://registry.npmjs.org/@cobusgreyling%2Floop/0.2.0 and pinned `cobusgreyling/loop-engineering` raw LICENSE/package metadata URLs in the register | Loop metadata, license, and process-tool identity |
| P05/P06/P63–P67 | https://github.com/atsushieno/uapmd/releases/tag/0.5.6 and pinned `atsushieno/uapmd` raw URLs in the register | UAPMD release, licenses, README, modules |
| R04-C20 | https://raw.githubusercontent.com/google/oboe/4468344c8fdfdd7df068d5abefe2d8615fd6b431/LICENSE | Oboe Apache-2.0 |
| R04-C22–C27 | Pinned `atsushieno/aap-core` and `atsushieno/aap-juce` raw/API URLs in the register | AAP core and AAP-JUCE identities, README, licenses, trees |
| P70/P74/P75 | https://raw.githubusercontent.com/juce-framework/JUCE/7aae7d8e8deb8413bb01633d2795ef9974a181c5/LICENSE.md, the same pin's `JUCE.spdx.json`, and https://juce.com/legal/juce-9-licence/ | JUCE license/SPDX and retained commercial-terms 403 |
| P71 | https://raw.githubusercontent.com/RustAudio/cpal/e1612d5d98152f8dc2a62e1b51ef7cbf4f7f26b7/LICENSE | CPAL Apache-2.0 |
| P72 | https://raw.githubusercontent.com/mackron/miniaudio/9634bedb5b5a2ca38c1ee7108a9358a4e233f14d/LICENSE | miniaudio public-domain/MIT alternatives |
| R06-S20/S26 | Pinned FluidSynth 2.6.1 raw LICENSE and LicensingFAQ URLs in the register | LGPL-2.1 and dated lay guidance |
| R06-S29–S31/S44/S45 | Pinned sfizz 1.2.3 raw license, README, and CMake URLs in the register | Root and configurable dependency evidence |
| R06-S35–S37 | Pinned TinySoundFont raw LICENSE, README, and header URLs in the register | Root/header notices, policy, example references |
| P09 | https://developer.android.com/studio/terms | Public Android SDK terms |
| P07/P08/P73 | https://developer.apple.com/support/terms/, https://developer.apple.com/support/terms/apple-developer-program-license-agreement/, and https://www.apple.com/legal/sla/docs/xcode.pdf | Public Apple terms pages and Xcode/SDK agreement |
| R05-M44/M46 | https://amei-music.github.io/midi2.0-docs/amei-pdf/M2-104-UM_v1-1-2_UMP_and_MIDI_2-0_Protocol_Specification.pdf and https://support.roli.com/helpdesk/attachments/36006155617 | UMP and historical MPE technical documents |
| R06-S42 | https://www.synthfont.com/sfspec24.pdf | Historical SF2 mirror with retained provenance limits |

## Source-qualified obligation notes

These are documentary observations, not application-specific legal determinations.

- BSD-2-Clause and MIT texts generally require retention of the copyright and permission/conditions notices in covered copies or substantial portions.
- BSD-3-Clause-style texts add a non-endorsement condition for contributor or holder names.
- Apache-2.0 requires retention of the license and relevant notices, identification of modified files, and preservation of attribution notices when a NOTICE file applies.
- Apache-2.0 also contains patent-license, termination, and trademark limits that must be evaluated against the actual use and distribution.
- LGPL-2.1 grants copying and modification subject to its terms and distinguishes the library, modified library, and works using the library.
- A selected LGPL distribution may require notices, corresponding library source, modification disclosure, and an ability to replace or relink the library, depending on the exact combination and delivery method.
- The FluidSynth FAQ is maintainer lay guidance rather than legal advice.
- Its 2011 App Store/relinking discussion and 2017 VST3 statement are historical observations and cannot settle current distribution.
- AGPLv3 includes source-conveyance conditions for covered distribution and a network-interaction source-offer condition for modified programs used over a network.
- AAP-JUCE or JUCE under an AGPL branch therefore requires exact combined-work, modification, interaction, and distribution analysis.
- A commercial license branch cannot be inferred from public repository availability or a failed terms request.
- CC BY 4.0 attribution duties for an icon/font surface do not clear recordings, compositions, performances, samples, presets, exported patches, product names, or trademarks.
- OFL, font-specific licenses, and code licenses must remain attached to the exact font identity and artifact rather than generalized across similarly named families.

## Platform SDK and distribution terms

### Android SDK terms (P09)

- **Fact:** sections 3.1–3.5 describe a limited SDK grant for developing applications compatible with Android and impose SDK-use and redistribution restrictions.
- **Fact:** those sections distinguish separately licensed open-source components from the rest of the SDK terms.
- **Fact:** sections 3.7–3.8 address Android/Google marks and preservation of copyright, trademark, and other proprietary notices.
- **Fact:** section 4.3 places privacy and user-information responsibilities on the developer.
- **Fact:** section 5.1 places responsibility for credential confidentiality on the developer.
- **Gap:** the exact SDK/NDK versions, target/min SDK, build inputs, store channel, account acceptance, and released native graph are not selected.
- **Owner decision:** credentials, account terms, signing, distribution, store use, and any legal conclusion remain human gates.

### Apple Xcode and SDK terms (P07/P08/P73)

- **Fact:** P73 is the public Xcode and Apple SDK agreement, document EA2002, with printed date `06/08/2026`; no locale interpretation is made.
- **Fact:** section 2.2 describes Apple-hardware/internal-test scope and refers to a separate distribution agreement for distribution.
- **Fact:** section 2.10 limits system-image use to the described Apple-platform purpose.
- **Fact:** the agreement recognizes that third-party materials can carry separate terms.
- **Gap:** P07/P08 public pages do not establish which version an owner account accepted or which Developer Program and distribution schedules apply.
- **Gap:** signing, entitlements, App Store channel, account, product identifiers, SDK version, and third-party AU/content scenario remain unselected.
- **Owner decision:** account acceptance, legal agreements, signing, and distribution require separate owner action.

Reading P09 or P73 is evidence collection only.
No account was used and no terms were accepted.
Native API documentation from R03–R05 is technical evidence, not a blanket source or binary redistribution license.

## Content, asset, and format separation

| Content surface | Current evidence | Rights that remain distinct | Reviewer/date/status |
| --- | --- | --- | --- |
| Real piano | Product plan requires an original or separately cleared playable piano | Recordings, performers, compositions where applicable, instrument/source provenance, editing, territories, platforms, redistribution, and export rights | Qualified review + owner / 2026-10-23 / **Not approved** |
| Ambient pad and warm synth | Product planning context only | Source recordings or synthesis material, preset author, names, metadata, redistribution, and exported-patch scope | Qualified review + owner / 2026-10-23 / **Not approved** |
| Four-layer/six-patch factory content | Workflow planning only | Authorship, constituent samples, preset parameters, names, artwork, distribution, derivative/export rights | Qualified review + owner / 2026-10-23 / **Not approved** |
| SoundFont/SF2 content | No candidate selected; TinySoundFont example excluded | Bank/sample recordings, zones, presets, names, performer/composition basis, embedded metadata, and redistribution | Qualified review + owner / 2026-10-23 / **Not approved** |
| SFZ content | No candidate selected | Instrument text, referenced samples, paths, metadata, names, and redistribution are separately sourced | Qualified review + owner / 2026-10-23 / **Not approved** |
| MIDI files | No product file selected; TinySoundFont example excluded | Composition, performance, arrangement, file provenance, metadata, and distribution | Qualified review + owner / 2026-10-23 / **Not approved** |
| Fonts and icons | Existing Flutter cache texts only; no custom selection | Exact font/icon binary, family/version, license, attribution, modification, embedding, and shipped-artifact evidence | Qualified review + owner / 2026-10-23 / **Not approved** |
| Artwork and branding | No candidate selected | Creator, source, trademarks, model/property concerns if applicable, modification, territories, and distribution | Qualified review + owner / 2026-10-23 / **Not approved** |
| Patch import/export | Capability unimplemented and format unselected | User-content ownership, third-party samples, metadata, privacy, notices, and permitted redistribution/export scope | Qualified review + owner / 2026-10-23 / **Not approved** |

- **Fact:** no approved real piano, sample set, recording, SoundFont, SFZ instrument, MIDI file, preset, starter patch, artwork, custom font, or icon exists.
- **Fact:** no artist/vendor sound or patch was copied during R07.
- **Fact:** source-library licenses do not clear recordings, compositions, performances, presets, trademarks, or product content.
- **Fact:** specification and format documents are distinct from implementation code and from data encoded in those formats.
- **Inference:** selecting an engine cannot satisfy the planned worship instrument without separately cleared musical content.
- **Recommendation:** create one future ledger row per exact code component and per exact content or asset rights chain.
- **Owner decision:** approve a separately evidenced real piano and factory-content plan before any implementation or bundling.

## Supply-chain, security, and privacy evidence gaps

The following are threat hypotheses and review needs, not observed vulnerabilities.

| Area | Evidence-backed gap or hypothesis | Required future evidence and owner |
| --- | --- | --- |
| Source identity | Tags, repository heads, registry metadata, and local caches can diverge | Exact commit/tag/archive hash, signed provenance when available, authoritative license/notices, and artifact-to-source mapping; qualified reviewer + owner |
| Transitive graph | Root licenses omit optional, vendored, generated, wrapper, plugin, test/tool, and platform branches | Reproducible selected build manifest, feature flags, submodules, package graph, SBOM, notices, and exclusions; build owner + Licensing/Security |
| Remote acquisition | Future registries, repositories, plugin catalogs, or update paths may be compromised | Approved origin allowlist, transport/signature/checksum method, failure policy, update policy, and retained provenance; Security + owner |
| Untrusted sound/format input | SF2/SFZ/MIDI/plugin metadata can be malformed, oversized, recursive, or path-bearing | Parser limits, path/symlink policy, memory/voice/zone bounds, fuzzing plan, rejection behavior, and safe diagnostics; Security + QA + owner |
| Private metadata | Paths, device names, patch names, plugin data, account identifiers, or proprietary filenames may enter logs/exports | Data inventory, minimization, retention/redaction, permission, export, and deletion policy; privacy review + owner |
| Account/credential handling | SDK/store/plugin access may require credentials or accepted terms | Named account owner, least privilege, secret storage/rotation, exact accepted terms/version, and authorized external action; owner only |
| Copyleft delivery | Static/dynamic linking, modification, replacement, relinking, network interaction, and store packaging alter the relevant questions | Exact binary/source relationship, source offer/materials, object/relink/replacement evidence, notices, and qualified scenario review |
| Content provenance | A file may combine code, recording, composition, performance, preset, name, art, and metadata rights | Rights-holder chain, creation/source records, grants, territory/platform/use/export scope, attribution, and revocation/replacement plan |
| Platform policy | Public SDK terms do not prove current account schedules or store acceptance | Exact SDK/tool version, account-accepted terms, channel, signing/entitlement plan, privacy disclosures, and store review basis |
| License text drift | Current website text may differ from an old candidate or accepted agreement | Pin the candidate-time body and separately record the operative account agreement; do not substitute current HEAD for historical evidence |

## Decision record by category

### Facts

1. Existing foundation metadata pins Flutter 3.44.8 and Dart 3.12.2 as recorded above.
2. The committed lock has 23 hosted packages and three SDK-labelled packages.
3. All 23 registry version/archive hashes and published/cache license comparisons reconcile as described.
4. The foundation declares `uses-material-design: true`; captured Material Icons and Roboto license texts are separate from binary provenance.
5. Loop 0.2.0 is a process tool, absent from the Flutter dependency graph.
6. UAPMD, AAP, JUCE, Oboe, CPAL, miniaudio, FluidSynth, sfizz, and TinySoundFont are investigated candidates, not selected dependencies.
7. Platform and specification documents describe technical or contractual surfaces; they do not establish product clearance.
8. No music/content asset has been selected, copied, downloaded, or approved.

### Inferences

1. Root-license labels alone cannot describe a future app because configuration and transitives determine the actual graph.
2. A package-cache license match improves traceability but does not authenticate the archive or prove inclusion in a released artifact.
3. Weak- or strong-copyleft feasibility depends on the exact linking, modification, delivery, source, replacement, and store scenario.
4. A dual-license candidate requires an explicit branch and applicable terms; silence cannot select a commercial or copyleft branch.
5. SDK access and API availability do not settle account, signing, redistribution, privacy, or store obligations.
6. Code clearance cannot supply sample, performance, composition, preset, art, font, trademark, or export rights.
7. Security/privacy controls must follow the selected input, plugin, acquisition, logging, and distribution design.

### Recommendations

1. Keep every row Not approved until the future checklist below is complete for one exact candidate and distribution scenario.
2. Prefer source pins and full authoritative bodies over package-page labels or secondary summaries.
3. Produce the actual selected graph and artifact manifest before qualified license review.
4. Track code, tools, SDKs, fonts/icons, samples, presets, specifications, and exported content as separate ledger items.
5. Preserve historical dates and caveats for old FAQs, store discussions, repository heads, mirrors, and public terms.
6. Treat untrusted plugin, format, and content files as bounded inputs in a later security design.

### Open questions

1. Which exact audio engine, hosting approach, native wrappers, build flags, and platform versions will be proposed?
2. Which resolved dependencies, vendor files, generated files, tools, tests/examples, and optional components enter each shipped artifact?
3. Which license branch and corresponding evidence would apply to any dual-licensed component?
4. What source, replacement, relink, notice, or network-source materials would the selected distribution require?
5. Which account-specific Apple, Android, store, plugin, or SDK terms would govern the actual release?
6. Which exact piano, pad, synth, patch, font, icon, and artwork sources will be proposed, and who holds each right?
7. Will users import or export patches, MIDI, SoundFonts, samples, presets, plugin data, or other third-party content?
8. What collection, permission, retention, diagnostic, and deletion design applies to user/device/plugin metadata?

### Owner decisions reserved

1. Whether to adopt any dependency, SDK, engine, wrapper, format implementation, font, icon, sample, instrument, patch, or service.
2. Whether to accept terms, create or use accounts, provide credentials, buy a license, sign, submit, or distribute.
3. Whether a qualified legal review is required and whether its conclusion is acceptable for the exact scenario.
4. Whether the source/provenance, security, privacy, content, platform, and distribution evidence is sufficient.
5. Whether to authorize a separate implementation task after all applicable gates pass.

## Future exact-candidate adoption evidence checklist

This procedure is proposed, unperformed, and unapproved.
It does not authorize installation, resolution, download, build, account use, terms acceptance, purchase, content acquisition, implementation, or distribution.

1. Name one exact candidate and intended role.
2. Freeze its version, full commit, tag, repository owner, canonical URL, and source/archive SHA-256.
3. Record the access date and preserve the authoritative license, every copyright file, NOTICE, attribution, and third-party inventory.
4. Authenticate the candidate archive or source checkout against the frozen identity without substituting a current branch.
5. Define the exact target platforms, SDK/tool versions, build mode, link mode, package channel, and distribution territories.
6. Select feature flags, optional components, plugins, wrappers, backends, submodules, vendor files, generated sources, examples, tests, and tools.
7. Generate a complete direct/transitive build graph and artifact-level SBOM for each platform/configuration.
8. Map every graph node and shipped file to license, copyright, notice, source, modification, patent, trademark, and attribution evidence.
9. For LGPL or similar branches, document modifications, corresponding source, notices, and the proposed replacement/relink/object-file method.
10. For AGPL or another strong-copyleft branch, document the covered work, modifications, distribution, network interaction, and source-delivery scenario.
11. For dual/commercial branches, capture the exact offered agreement, version, price/term scope, acceptance authority, and continuing obligations.
12. Record platform SDK/store/account terms that actually apply; do not infer them from public API documentation.
13. For each font, icon, sample, recording, composition, performance, preset, patch, model, or artwork item, record creator, rights holder, provenance, exact bytes/hash, and grant.
14. State permitted commercial use, modification, embedding, territories, platforms, copies, attribution, sublicensing, redistribution, and user export/import scope.
15. Exclude every example or fixture whose provenance is unknown; use a separately cleared future fixture.
16. Define source acquisition, checksum/signature verification, update, compromise, revocation, and replacement procedures.
17. Define security limits for untrusted files, paths, metadata, plugin discovery, resource exhaustion, and diagnostic leakage.
18. Define privacy data flows, permissions, user notice, retention, redaction, export, deletion, and credential handling.
19. Have QA/Performance verify evidence completeness and reproduce identity/hash/graph claims.
20. Have an independent Licensing/Security Reviewer assess the exact evidence and scenario; obtain qualified counsel where the owner requires it.
21. Record the owner decision with reviewer, date, exact evidence SHAs, accepted conditions, residual risks, and an explicit approval state.
22. Only after that decision, create a separately authorized implementation task with bounded paths and verification.
23. Re-run the evidence and review process whenever a version, commit, build flag, transitive graph, content byte, platform, channel, or agreement changes.

## Required review record

Before changing an approval state, attach or link authoritative evidence and record:

- exact item, version, full source identity, and hashes;
- intended technical role and whether it is development-only or shipped;
- selected build, link, platform, content, and distribution scope;
- direct and transitive licenses, notices, source/replacement/relink obligations, and unresolved questions;
- asset provenance and use rights where content is involved;
- security, privacy, account, credential, and platform-term implications;
- independent reviewer, review date, evidence SHA, owner, and decision;
- the resulting approval state and any conditions or expiry/re-review trigger.

A technical approval does not replace this license gate.
This ledger does not provide legal advice.
No R07 row is approved.
