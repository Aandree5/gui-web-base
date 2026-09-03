# GUI Web Base

<div align="center">
  <img src="https://github.com/Aandree5/gui-web-base/blob/main/images/logo_256.png?raw=true" alt="Logo" />
</div>

![Deploy Docker image](https://img.shields.io/github/actions/workflow/status/aandree5/gui-web-base/docker-deploy.yml?logoColor=white&label=Deploy%20Docker%20image&logo=github) 
![GitHub Release](https://img.shields.io/github/v/release/aandree5/gui-web-base?logoColor=white&color=teal&label=Release&logo=rocket) 
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/aandree5/gui-web-base?logoColor=white&color=yellow&label=Last%20commit&logo=data:image/svg+xml;base64,PCFET0NUWVBFIHN2ZyBQVUJMSUMgIi0vL1czQy8vRFREIFNWRyAxLjEvL0VOIiAiaHR0cDovL3d3dy53My5vcmcvR3JhcGhpY3MvU1ZHLzEuMS9EVEQvc3ZnMTEuZHRkIj4KDTwhLS0gVXBsb2FkZWQgdG86IFNWRyBSZXBvLCB3d3cuc3ZncmVwby5jb20sIFRyYW5zZm9ybWVkIGJ5OiBTVkcgUmVwbyBNaXhlciBUb29scyAtLT4KPHN2ZyB3aWR0aD0iNjRweCIgaGVpZ2h0PSI2NHB4IiB2aWV3Qm94PSIwIDAgMjQgMjQiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+Cg08ZyBpZD0iU1ZHUmVwb19iZ0NhcnJpZXIiIHN0cm9rZS13aWR0aD0iMCIvPgoNPGcgaWQ9IlNWR1JlcG9fdHJhY2VyQ2FycmllciIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIi8+Cg08ZyBpZD0iU1ZHUmVwb19pY29uQ2FycmllciI+IDxwYXRoIGQ9Ik0yMCAxMFY3QzIwIDUuODk1NDMgMTkuMTA0NiA1IDE4IDVINkM0Ljg5NTQzIDUgNCA1Ljg5NTQzIDQgN1YxME0yMCAxMFYxOUMyMCAyMC4xMDQ2IDE5LjEwNDYgMjEgMTggMjFINkM0Ljg5NTQzIDIxIDQgMjAuMTA0NiA0IDE5VjEwTTIwIDEwSDRNOCAzVjdNMTYgM1Y3IiBzdHJva2U9IiNmZmZmZmYiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIi8+IDxyZWN0IHg9IjYiIHk9IjEyIiB3aWR0aD0iMyIgaGVpZ2h0PSIzIiByeD0iMC41IiBmaWxsPSIjZmZmZmZmIi8+IDxyZWN0IHg9IjEwLjUiIHk9IjEyIiB3aWR0aD0iMyIgaGVpZ2h0PSIzIiByeD0iMC41IiBmaWxsPSIjZmZmZmZmIi8+IDxyZWN0IHg9IjE1IiB5PSIxMiIgd2lkdGg9IjMiIGhlaWdodD0iMyIgcng9IjAuNSIgZmlsbD0iI2ZmZmZmZiIvPiA8L2c+Cg08L3N2Zz4=)  
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/aandree5/gui-web-base/latest?logoColor=white&color=orange&label=Image%20size&logo=data:image/svg+xml;base64,PCFET0NUWVBFIHN2ZyBQVUJMSUMgIi0vL1czQy8vRFREIFNWRyAxLjEvL0VOIiAiaHR0cDovL3d3dy53My5vcmcvR3JhcGhpY3MvU1ZHLzEuMS9EVEQvc3ZnMTEuZHRkIj4KDTwhLS0gVXBsb2FkZWQgdG86IFNWRyBSZXBvLCB3d3cuc3ZncmVwby5jb20sIFRyYW5zZm9ybWVkIGJ5OiBTVkcgUmVwbyBNaXhlciBUb29scyAtLT4KPHN2ZyB3aWR0aD0iNjRweCIgaGVpZ2h0PSI2NHB4IiB2aWV3Qm94PSIwIDAgMTUgMTUiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgc3Ryb2tlPSIjZmZmZmZmIj4KDTxnIGlkPSJTVkdSZXBvX2JnQ2FycmllciIgc3Ryb2tlLXdpZHRoPSIwIi8+Cg08ZyBpZD0iU1ZHUmVwb190cmFjZXJDYXJyaWVyIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiLz4KDTxnIGlkPSJTVkdSZXBvX2ljb25DYXJyaWVyIj4gPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik0xMS41IDMuMDQ5OTlDMTEuNzQ4NSAzLjA0OTk5IDExLjk1IDMuMjUxNDYgMTEuOTUgMy40OTk5OVY3LjQ5OTk5QzExLjk1IDcuNzQ4NTIgMTEuNzQ4NSA3Ljk0OTk5IDExLjUgNy45NDk5OUMxMS4yNTE1IDcuOTQ5OTkgMTEuMDUgNy43NDg1MiAxMS4wNSA3LjQ5OTk5VjQuNTg2MzlMNC41ODYzOCAxMS4wNUg3LjQ5OTk5QzcuNzQ4NTIgMTEuMDUgNy45NDk5OSAxMS4yNTE1IDcuOTQ5OTkgMTEuNUM3Ljk0OTk5IDExLjc0ODUgNy43NDg1MiAxMS45NSA3LjQ5OTk5IDExLjk1TDMuNDk5OTkgMTEuOTVDMy4zODA2NCAxMS45NSAzLjI2NjE4IDExLjkwMjYgMy4xODE3OSAxMS44MTgyQzMuMDk3NCAxMS43MzM4IDMuMDQ5OTkgMTEuNjE5MyAzLjA0OTk5IDExLjVMMy4wNDk5OSA3LjQ5OTk5QzMuMDQ5OTkgNy4yNTE0NiAzLjI1MTQ2IDcuMDQ5OTkgMy40OTk5OSA3LjA0OTk5QzMuNzQ4NTIgNy4wNDk5OSAzLjk0OTk5IDcuMjUxNDYgMy45NDk5OSA3LjQ5OTk5TDMuOTQ5OTkgMTAuNDEzNkwxMC40MTM2IDMuOTQ5OTlMNy40OTk5OSAzLjk0OTk5QzcuMjUxNDYgMy45NDk5OSA3LjA0OTk5IDMuNzQ4NTIgNy4wNDk5OSAzLjQ5OTk5QzcuMDQ5OTkgMy4yNTE0NiA3LjI1MTQ2IDMuMDQ5OTkgNy40OTk5OSAzLjA0OTk5TDExLjUgMy4wNDk5OVoiIGZpbGw9IiMwMDAwMDAiLz4gPC9nPgoNPC9zdmc+) 
![Docker Pulls](https://img.shields.io/docker/pulls/aandree5/gui-web-base?logoColor=white&color=blue&label=Docker%20pulls&logo=docker) 
![GitHub License](https://img.shields.io/github/license/aandree5/gui-web-base?logoColor=white&color=red&label=License&logo=data:image/svg+xml;base64,PCFET0NUWVBFIHN2ZyBQVUJMSUMgIi0vL1czQy8vRFREIFNWRyAxLjEvL0VOIiAiaHR0cDovL3d3dy53My5vcmcvR3JhcGhpY3MvU1ZHLzEuMS9EVEQvc3ZnMTEuZHRkIj4KDTwhLS0gVXBsb2FkZWQgdG86IFNWRyBSZXBvLCB3d3cuc3ZncmVwby5jb20sIFRyYW5zZm9ybWVkIGJ5OiBTVkcgUmVwbyBNaXhlciBUb29scyAtLT4KPHN2ZyB3aWR0aD0iNjRweCIgaGVpZ2h0PSI2NHB4IiB2aWV3Qm94PSIwIDAgMjQgMjQiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+Cg08ZyBpZD0iU1ZHUmVwb19iZ0NhcnJpZXIiIHN0cm9rZS13aWR0aD0iMCIvPgoNPGcgaWQ9IlNWR1JlcG9fdHJhY2VyQ2FycmllciIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIi8+Cg08ZyBpZD0iU1ZHUmVwb19pY29uQ2FycmllciI+IDxwYXRoIG9wYWNpdHk9IjAuMSIgZD0iTTEyIDE3SDdDNS44OTU0MyAxNyA1IDE2LjEwNDYgNSAxNVY1QzUgMy44OTU0MyA1Ljg5NTQzIDMgNyAzSDE2QzE3LjEwNDYgMyAxOCAzLjg5NTQzIDE4IDVWMTlDMTggMjAuMTA0NiAxNy4xMDQ2IDIxIDE2IDIxQzE0Ljg5NTQgMjEgMTQgMjAuMTA0NiAxNCAxOUMxNCAxNy44OTU0IDEzLjEwNDYgMTcgMTIgMTdaIiBmaWxsPSIjZmZmZmZmIi8+IDxwYXRoIGQ9Ik0xOSAzSDlWM0M3LjExNDM4IDMgNi4xNzE1NyAzIDUuNTg1NzkgMy41ODU3OUM1IDQuMTcxNTcgNSA1LjExNDM4IDUgN1YxMC41VjE3IiBzdHJva2U9IiNmZmZmZmYiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIi8+IDxwYXRoIGQ9Ik0xNCAxN1YxOUMxNCAyMC4xMDQ2IDE0Ljg5NTQgMjEgMTYgMjFWMjFDMTcuMTA0NiAyMSAxOCAyMC4xMDQ2IDE4IDE5VjlWNC41QzE4IDMuNjcxNTcgMTguNjcxNiAzIDE5LjUgM1YzQzIwLjMyODQgMyAyMSAzLjY3MTU3IDIxIDQuNVY0LjVDMjEgNS4zMjg0MyAyMC4zMjg0IDYgMTkuNSA2SDE4LjUiIHN0cm9rZT0iI2ZmZmZmZiIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiLz4gPHBhdGggZD0iTTE2IDIxSDVDMy44OTU0MyAyMSAzIDIwLjEwNDYgMyAxOVYxOUMzIDE3Ljg5NTQgMy44OTU0MyAxNyA1IDE3SDE0IiBzdHJva2U9IiNmZmZmZmYiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIi8+IDxwYXRoIGQ9Ik05IDdIMTQiIHN0cm9rZT0iI2ZmZmZmZiIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiLz4gPHBhdGggZD0iTTkgMTFIMTQiIHN0cm9rZT0iI2ZmZmZmZiIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiLz4gPC9nPgoNPC9zdmc+)

A Docker base image to simplify the creation of downstream containers that run Linux GUI apps in a web browser.

## ⚡ Features

- **Linux apps in your browser**
- **Rootless runtime** - Never needs root, and runs as any `--user` you choose.
- **Integrated clipboard** - Seamless copy-paste between app and browser.
- **Audio forwarding** - Stream audio from the app to your browser seamlessly.
- **Automatic restart** - Apps relaunch automatically when closed.
- **HTTPS redirect** – Enforces secure connections over HTTPS, by default.
- **Launch apps from UI** – `.desktop` entries are exposed and can be launched via the UI.

## ✨ Getting Started

This image is designed to be used as a **base** for `Dockerfiles`.  
Install a desired GUI app and call the following to launch it.

```dockerfile
CMD ["start-app","[--no-restart]", "<app>", "[args...]"]
```

- ### Example `Dockerfile` with `xterm`

```dockerfile
# Prefer version pinning (at least a major, e.g. :v1)
# Pinning to <major>.<minor> (e.g. :v1.1) limits updates to patches only.
FROM aandree5/gui-web-base:v1.1

# Install app
USER root
RUN apt-get update && \
    apt-get install -y my-app && \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
USER gwb

# Start app
CMD ["start-app", "xterm"]
```

- ### Build and run

```bash
# Build the image
docker build -t gui-web-xterm .

# Run it
docker run -d -p 443:5443 gui-web-xterm
```

> _To access the app open `https://localhost` in the browser._

## ⚙️ Configuration

- ### **Build-Time Arguments**

These can be set using `--build-arg` during `docker build` to define default values baked into the image.

| Argument       | Description                                    | Default    | Example                             |
| -------------- | ---------------------------------------------- | ---------- | ----------------------------------- |
| `GWB_RUN_BASE` | Base directory for per-user runtime state.     | `/run/gwb` | `--build-arg GWB_RUN_BASE=/var/gwb` |
| `UMASK`        | Default file creation mask applied at runtime. | `077`      | `--build-arg UMASK=027`             |

- ### **Runtime Environment Variables**

These can be overridden by any downstream image or container using `ENV` or `-e` flags.

| Variable       | Description                                                                                                                                                                                                                | Default    | Example                                                          |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------- | ---------------------------------------------------------------- |
| `APP_DIRS`     | Space-separated list of directories the app must be able to write to. Checked at startup, missing ones are created where possible, and the container exits with a clear error if any are not writable by the running user. | _(unset)_  | `ENV APP_DIRS="/myapp/config /var/cache"` or `-e APP_DIRS="..."` |
| `GWB_RUN_BASE` | Base directory for per-user runtime state. Each user gets `<base>/<uid>/`.                                                                                                                                                 | `/run/gwb` | `ENV GWB_RUN_BASE=/var/gwb` or `-e GWB_RUN_BASE=/var/gwb`        |
| `UMASK`        | File creation mask used during startup. Controls default permissions for generated files.                                                                                                                                  | `077`      | `ENV UMASK=027` or `-e UMASK=027`                                |
| `ALLOW_HTTP`   | Allows plain HTTP connections. When `false`, HTTP is redirected to HTTPS.                                                                                                                                                  | `true`     | `ENV ALLOW_HTTP=false` or `-e ALLOW_HTTP=false`                  |

> `ALLOW_HTTP` is recomended set to `false` to keep all traffic secure, even with self-signed certificates. In some cases it can be usefull to allow HTTP access, shuch as if the app is going to be behind a reverse proxy, which is handling SSL certificates.

- ### **Permissions**

The container never runs as root. It runs as the default `gwb` user, or as whatever identity you pass to `--user`.

- **Running as any user.** Pass `--user <uid>:<gid>` to match a mounted folder's ownership, with no rebuild and no root:

  ```bash
  # Run as the current host user so mounted folders line up
  docker run -d -p 443:5443 \
    --user "$(id -u):$(id -g)" \
    -v "$PWD/data:/myapp/data" \
    -e APP_DIRS="/myapp/data" \
    my-app
  ```

  All runtime state (home directory, `XDG_RUNTIME_DIR`, SSL certificate, NGINX logs and temp files) are created at startup under `/run/gwb/<uid>/`, so they are always owned by the user actually running the container. Everything else in the image is read-only to the app.

- **Mounted folders** only need to be writable by the uid/gid the container is running as. Any directory listed in `APP_DIRS` is checked at startup and the container exits with a clear error if it isn't writable.

- **Persistence.** Mount a volume at `/run/gwb` to keep the generated SSL certificate and runtime state between runs. Otherwise a new self-signed certificate is generated on each start (and whenever the uid changes). A read-only root filesystem works too, as long as the paths written at runtime stay writable:

  ```bash
  docker run -d -p 443:5443 --read-only \
    --tmpfs /run/gwb:mode=1777 \
    --tmpfs /run/dbus:mode=1777 \
    --tmpfs /tmp:mode=1777 \
    --tmpfs /tmp/.X11-unix:mode=1777 \
    my-app
  ```

- **Hardening.** Because nothing in the image ever needs to escalate privileges, downstream images can be run with `--security-opt no-new-privileges`.

- **Downstream Dockerfiles** inherit `USER gwb`, so switch back to `root` for any build step that writes outside `/run/gwb` — installing packages, adding files, or running `configure-xpra`, then switch back before the final image:

  ```dockerfile
  FROM aandree5/gui-web-base:v1.1

  USER root
  RUN apt-get update && apt-get install -y my-app && apt-get clean
  RUN configure-xpra --content-type class-instance:my-app=text
  COPY my-config/ /opt/my-app/config/
  USER gwb

  CMD ["start-app", "my-app"]
  ```

- ### **App Launch Flags**

These options can be passed to `CMD` in your Dockerfile to customize app behavior.

| Option                    | Description                                                                   | Default        | Example                                                      |
| ------------------------- | ----------------------------------------------------------------------------- | -------------- | ------------------------------------------------------------ |
| `--no-restart`            | Prevents the app from restarting when its window is closed.                   | _(enabled)_    | `CMD ["start-app", "--no-restart", "my-app"]`                |
| `--title`                 | Sets the browser tab title for the web interface.                             | `GUI Web Base` | `CMD ["start-app", "--title", "My Web App", "my-app"]`       |
| `--min-quality` \*        | Sets the minimum image encoding quality (1–100). Lower values save bandwidth. | `0` _(auto)_   | `CMD ["start-app", "--min-quality", "80", "my-app"]`         |
| `--min-speed` \*          | Sets the minimum encoding speed (1–100). Higher values reduce latency.        | `0` _(auto)_   | `CMD ["start-app", "--min-speed", "50", "my-app"]`           |
| `--auto-refresh-delay` \* | Delay (in seconds) before sending a lossless refresh after lossy updates.     | `0.25`         | `CMD ["start-app", "--auto-refresh-delay", "0.2", "my-app"]` |

> \* See the [Xpra manual](https://xpra.org/manual) for more information.

- ### **Xpra Content-Type Mapping**

Use the `configure-xpra` script during build to append content-type rules to Xpra’s config files.
Pass mappings using `--content-type` in the format `[fallback:]<type>:<key>=<value>`.

```dockerfile
# Multiple flags can be passed
# If the value contains spaces or special characters, wrap the value in quotes.
USER root
RUN configure-xpra \
  --content-type role:gimp-dock=text \
  --content-type "title:- Gmail -=text" \
  --content-type class-instance:xterm=text \
  --content-type commands:my_special_command=picture \
  --content-type fallback:role:browser=browser
USER gwb
```

- #### Supported Match Types

| Type             | Format Example                                     | Description                                                                     |
| ---------------- | -------------------------------------------------- | ------------------------------------------------------------------------------- |
| `role`           | `role:gimp-dock=text`                              | Matches the window's internal role name (e.g. toolbars, docks, dialogs).        |
| `title`          | `title:- Gmail -=text`                             | Matches the window title shown in the title bar.                                |
| `class-instance` | `class-instance:xterm=text`                        | Matches the X11 class/instance name of the window.                              |
| `commands`       | `command:my_special_command=picture`               | Matches the command used to launch the application.                             |
| `fallback`       | `fallback:role:browser=browser` (generic fallback) | Applies when no other match succeeds and is evaluated last as a catch-all rule. |

> For more details, see the [Xpra tuning documentation](https://github.com/Xpra-org/xpra/blob/master/docs/Usage/Encodings.md#tuning).

## 🎛️ Menu Integration

This image includes a built-in freedesktop-compliant menu file that allows installed apps with `.desktop` files to be discovered and launched from the UI.

If an app provides a `.desktop` entry (installed either to `/usr/share/applications` or `~/.local/share/applications`), it will automatically appear in the browser-based menu, no extra configuration needed.

## 🏷️ Versioning & Tags

This project follows [Semantic Versioning](https://semver.org/) and uses automated releases.

## Tag Overview

| Format                     | Example  | Description                                             |
| -------------------------- | -------- | ------------------------------------------------------- |
| `latest`                   | -        | Always the newest, may include breaking changes.        |
| `v<major>`                 | `v1`     | Latest stable for a major version. No breaking changes. |
| `v<major>.<minor>`         | `v1.1`   | Latest patch for a minor version. No new featues.       |
| `v<major>.<minor>.<patch>` | `v1.1.0` | Fixed version, only changes if manually updated.        |

## 🛠️ Contributing

Contributions are welcome! Please follow these steps to get set up:

1. **Clone the repository**:

   ```bash
   git clone https://github.com/Aandree5/gui-web-base.git
   cd gui-web-base
   ```

2. **Install pre-commit hooks** (for license headers, linting, etc.):

   ```bash
   pip install pre-commit
   pre-commit install
   ```

3. **Follow [Conventional Commits](https://www.conventionalcommits.org/)** for commit messages:
   - `feat:` - New feature
   - `fix:` - Bug fix
   - `docs:` - Documentation changes
   - `chore:` - Maintenance or tooling
   - `ci:` - CI/CD or workflow updates
   - `refactor:` - Code improvements without changing behavior
   - `revert:` - Revert a previous commit

4. **Open a Pull Request** against `main`.

## 📦 Tech Stack Overview

- **Debian `trixie-slim`**  
  Stable Linux base, optimized for performance and size.

- **[Xpra](https://github.com/Xpra-org/xpra/)**  
  Enables remote access to Linux desktop apps via the web.

- **[Xpra HTML5 Client](https://github.com/Xpra-org/xpra-html5)**  
  For interacting with GUI apps through Xpra.

## 📚 Resources

- [Code of Conduct](./CODE_OF_CONDUCT.md)
- [Contributing Guide](./CONTRIBUTING.md)
- [Apache 2.0 License](./LICENSE)
- [Security Policy](./SECURITY.md)

## ☕ Support

If you find the project useful, consider supporting its development! Your donations help cover costs and fund future improvements.

You can support through:

[![Static Badge](https://img.shields.io/badge/github-sponsor-red?logo=github&link=https%3A%2F%2Fgithub.com%2Fsponsors%2FAandree5%3Ffrequency%3Done-time%26sponsor%3DAandree5)](https://github.com/sponsors/Aandree5) 
[![Static Badge](https://img.shields.io/badge/liberapay-donate-yellow?logo=liberapay&link=https%3A%2F%2Fliberapay.com%2FAandree5)](https://liberapay.com/Aandree5/) 
[![Static Badge](https://img.shields.io/badge/stripe-donate-blue?logo=stripe)](https://donate.stripe.com/dRmcN41Z60eO3efeMCb7y00)
