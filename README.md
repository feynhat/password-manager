# 🔐 password-manager

A simple CLI-based password manager written in Bash, powered by OpenSSL encryption.

---

## Features

- Securely store and retrieve passwords from the command line
- AES encryption via OpenSSL — no third-party password vaults required
- Minimal dependencies: just Bash and OpenSSL
- Simple, interactive menu interface

---

## Requirements

- **Bash** — pre-installed on most Unix-based systems
- **OpenSSL** — available as `openssl` on Arch and Debian-based distros

---

## Usage

```bash
./password_manager.sh
```

On first run, you will be prompted to set a **master password**. This password
is used to encrypt and decrypt all stored entries.

### Menu Options

| Option | Description |
|--------|-------------|
| `1` | Add a new account password |
| `2` | Retrieve a stored password |
| `3` | List all saved accounts |
| `4` | Exit |

---

## Project Structure

```
password-manager/
├── 📁 password_manager.sh      # Main script to run
├── 📁 src/                     # Initialization / management scripts
└── 📁 data/
    ├── 📄 .MASTER              # Encrypted master password
    └── 📁 passwords/           # Local storage of encrypted passwords
```

---

## Security

Passwords are encrypted using **OpenSSL** with a master password that you
provide on first run. All encrypted passwords are stored locally in the
`data/passwords/` directory — nothing is sent over the network.

> ⚠️ **Keep your master password safe.** There is no recovery mechanism if it is
> lost.

---
