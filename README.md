# nix-mactex

MacTeX相当のtexliveFullを提供するNix flakeです。
`.latexmkrc`などのプロジェクト設定はここには含めず、各プロジェクト側で管理します。

MacTeX本体とは無関係のリポジトリです。
MacTeX相当とは中身のTeX Live(scheme-full)が同一という意味で、MacTeXが同梱するMac向けGUIツールは含まれません。

## 目的

プロジェクトごとにTeX Liveをインストールし直す手間をなくすため、LaTeX環境をこのflakeに切り出しています。
各LaTeXプロジェクト側は`direnv` / `nix develop`経由で参照するだけで、再現可能な環境が使えます。

## 収録パッケージ

- `texliveFull`
- `ghostscript`

## 必要要件

- macOS / Linux
- [Nix](https://nixos.org/download)
  - `~/.config/nix/nix.conf`などに以下が必要です:
    ```
    experimental-features = nix-command flakes
    ```

## 推奨ディレクトリ構成

基本は各プロジェクト直下に`.envrc`を置きます。
`.latexmkrc` などプロジェクト固有の設定も同じ場所に置きます。

```
latex/
├── project-a/
│   ├── .envrc # use flake github:reinmuth66/nix-mactex/v2025-r78234+gs10.07.1
│   ├── .latexmkrc
│   └── main.tex
├── project-b/
│   ├── .envrc # use flake github:reinmuth66/nix-mactex/v2025-r78234+gs10.07.1
│   ├── .latexmkrc
│   └── main.tex
└── project-c/
    ├── .envrc # use flake github:reinmuth66/nix-mactex/v2024-r72190+gs10.03.1
    ├── .latexmkrc
    └── main.tex
```

## 使い方

### direnv を使う場合

[direnv](https://direnv.net/)と[nix-direnv](https://github.com/nix-community/nix-direnv)が必要です。

1. 各プロジェクトディレクトリに `.envrc` を作成し、以下を記入する。

   ```
   use flake github:reinmuth66/nix-mactex/<タグ名>
   ```

   `<タグ名>`は[Releases](https://github.com/reinmuth66/nix-mactex/releases)から選びます。

2. そのディレクトリで有効化する。

   ```sh
   direnv allow
   ```

### direnv を使わない場合

その都度シェルに入るなら、プロジェクトディレクトリで以下を実行する。

```sh
nix develop github:reinmuth66/nix-mactex/<タグ名>
```

## タグの選び方

- 基本的には[Releases](https://github.com/reinmuth66/nix-mactex/releases)の最新タグを使ってください。
- タグを省略した`main`追従は、通常の利用では非推奨です。
- CIはビルドが通ることまでしか確認していません。新しいタグに切り替える前に、一度自分の文書で試しビルドすることを推奨します。

## メンテナンス

- タグの切り替えを繰り返すとディスク容量を圧迫するため、適宜`nix-collect-garbage`を実行してください。
