# Dotfiles · Entorno Linux reproducible

Configuración personal y scripts para reconstruir mi entorno de desarrollo Linux de forma reproducible.

El objetivo de este repositorio no es copiar todo el `$HOME`, sino **recrear el entorno de desarrollo** instalando las herramientas necesarias y restaurando únicamente las configuraciones que quiero versionar.

---

## 🎯 Objetivo

Este repositorio permite preparar una instalación Linux nueva con:

* Zsh + Oh My Zsh
* Oh My Posh
* Git + configuración personalizada
* Git Delta
* Node.js LTS mediante NVM
* pnpm
* Angular CLI
* OpenCode
* eza
* Fastfetch
* fzf
* zoxide
* direnv
* micro
* bat
* FiraCode Nerd Font
* configuración de Git
* configuración de Zsh
* configuración de Fastfetch
* configuración de micro
* configuración de Oh My Posh
* configuración SSH para GitHub

Las claves privadas, credenciales y otros datos sensibles **no forman parte del repositorio**.

---

## 🖥️ Entornos probados

El bootstrap se ha probado en:

| Entorno                    | Estado                 |
| -------------------------- | ---------------------- |
| Debian 13 (Trixie) · WSL2  | ✅                      |
| Linux Mint 21.3 (Virginia) | ✅                      |
| Ubuntu / WSL2              | 🟡 compatible previsto |

El objetivo es mantener compatibilidad entre distribuciones Debian/Ubuntu sin depender exclusivamente de los paquetes disponibles en los repositorios de cada distribución.

---

## 📁 Estructura

```text
dotfiles/
├── config/
│   ├── fastfetch/
│   │   └── config.jsonc
│   ├── micro/
│   │   └── bindings.json
│   └── oh-my-posh/
│       └── unicorn.json
│
├── git/
│   └── gitconfig
│
├── home/
│   ├── .angular-config.json
│   └── .zshrc
│
├── install/
│   ├── apt.sh
│   ├── config.sh
│   ├── fonts.sh
│   ├── node.sh
│   ├── shell.sh
│   └── tools.sh
│
├── ssh/
│   └── config
│
├── .gitignore
├── bootstrap.sh
└── README.md
```

### `bootstrap.sh`

Punto de entrada principal.

Ejecuta los scripts de instalación en orden:

```text
1. Paquetes del sistema
2. Fuentes
3. Zsh + Oh My Zsh
4. Node.js + herramientas frontend
5. Herramientas externas
6. Configuración
```

Además:

* conserva la identidad Git existente;
* configura `merge.conflictstyle` según la versión de Git;
* establece Zsh como shell predeterminada;
* muestra las tareas que deben hacerse manualmente.

---

# 🚀 Instalación desde cero

## 1. Preparar la máquina

Instalar una distribución Linux limpia.

Por ejemplo:

* Debian
* Ubuntu
* Linux Mint
* WSL2

Es necesario disponer de un usuario normal con permisos `sudo`.

---

## 2. Instalar Git

Git es necesario para clonar el repositorio.

```bash
sudo apt update
sudo apt install -y git
```

Comprobar:

```bash
git --version
```

---

## 3. Clonar el repositorio

### Opción inicial: HTTPS

Si todavía no tenemos configurado SSH:

```bash
git clone https://github.com/z3nit-dev/dotfiles.git ~/dotfiles
```

Entrar en el repositorio:

```bash
cd ~/dotfiles
```

> El repositorio puede clonarse inicialmente mediante HTTPS. Una vez configurado SSH, conviene cambiar `origin` a SSH.

---

## 4. Ejecutar el bootstrap

```bash
cd ~/dotfiles
./bootstrap.sh
```

Si el script no tiene permisos de ejecución:

```bash
chmod +x bootstrap.sh install/*.sh
```

y después:

```bash
./bootstrap.sh
```

Durante la ejecución puede solicitar:

* contraseña de `sudo`;
* nombre para Git si no existe;
* email para Git si no existe.

El script es idempotente en las principales instalaciones: si una herramienta ya está instalada, intenta evitar reinstalarla.

---

# 🧰 Qué instala

## Paquetes del sistema

`install/apt.sh` instala las dependencias disponibles mediante APT:

```text
zsh
git
curl
wget
unzip
fzf
direnv
keychain
micro
bat
zoxide
fontconfig
xz-utils
```

---

## Herramientas externas

`install/tools.sh` instala herramientas que no están disponibles de forma uniforme en los repositorios estándar.

### eza

Se utiliza el repositorio de eza:

```text
deb.gierens.de
```

### Fastfetch

La instalación depende de la distribución:

* Debian → paquete de Debian;
* Ubuntu / Linux Mint → PPA;
* otras distribuciones → error explícito.

### Git Delta

Se descarga la última release disponible de Git Delta desde GitHub y se instala el paquete `.deb`.

### Oh My Posh

Se instala mediante su instalador oficial.

### OpenCode

Se instala mediante su instalador oficial.

La instalación utiliza:

```text
--no-modify-path
```

para evitar modificaciones automáticas de `.bashrc`.

El PATH se controla desde `.zshrc`.

---

# 🟢 Node.js y herramientas frontend

`install/node.sh` utiliza NVM para gestionar Node.js.

El sistema puede tener una versión de Node instalada mediante APT, pero eso **no determina la versión utilizada por el entorno de desarrollo**.

El script comprueba el estado de NVM mediante:

```bash
nvm current
```

y, si no existe una versión gestionada por NVM, instala Node.js LTS.

Actualmente se utiliza:

```text
Node.js → LTS
pnpm    → 12.4.2
Angular → 22.0.5
```

La versión de Node no se fija en el script: se utiliza la rama LTS disponible en el momento de la instalación.

---

# 🐚 Zsh

Se instala:

* Zsh
* Oh My Zsh
* zsh-autosuggestions
* zsh-syntax-highlighting

Después del bootstrap se establece Zsh como shell predeterminada.

Comprobar:

```bash
echo "$SHELL"
```

y:

```bash
zsh --version
```

Puede ser necesario cerrar y volver a abrir la sesión para que todos los cambios queden activos.

---

# 🎨 Fuentes

Se instala:

```text
FiraCode Nerd Font
```

en:

```text
~/.local/share/fonts/FiraCode
```

Después se reconstruye la caché de fuentes.

---

# ⚙️ Configuración restaurada

`install/config.sh` copia los archivos versionados hacia sus ubicaciones correspondientes.

Antes de sobrescribir un archivo existente, crea una copia de seguridad en:

```text
~/.dotfiles-backup/
```

con una carpeta por fecha y hora.

Ejemplo:

```text
~/.dotfiles-backup/20261002-132500/
```

Esto permite recuperar la configuración anterior si fuese necesario.

---

# 🔐 SSH + GitHub

Las claves SSH **NO están almacenadas en este repositorio**.

Cada máquina debe tener sus propias claves.

Esto es intencionado.

## Crear identidad personal

```bash
ssh-keygen \
    -t ed25519 \
    -C "github-personal" \
    -f ~/.ssh/id_ed25519_github_personal
```

Crear identidad profesional:

```bash
ssh-keygen \
    -t ed25519 \
    -C "github-profesional" \
    -f ~/.ssh/id_ed25519_github_profesional
```

Esto genera:

```text
~/.ssh/id_ed25519_github_personal
~/.ssh/id_ed25519_github_personal.pub

~/.ssh/id_ed25519_github_profesional
~/.ssh/id_ed25519_github_profesional.pub
```

Las claves sin `.pub` son privadas y **nunca deben entrar en Git**.

---

## Añadir la clave pública a GitHub

Mostrar la clave personal:

```bash
cat ~/.ssh/id_ed25519_github_personal.pub
```

Copiar la línea completa y añadirla en GitHub:

```text
Settings
→ SSH and GPG keys
→ New SSH key
```

Tipo:

```text
Authentication Key
```

El mismo procedimiento se realiza para la cuenta profesional.

---

## Configuración SSH

El repositorio contiene una configuración SSH con aliases para separar las identidades.

Conceptualmente:

```text
github-personal
github-profesional
```

Esto permite seleccionar explícitamente qué clave utilizar.

Comprobar la identidad personal:

```bash
ssh -T git@github-personal
```

Una autenticación correcta devuelve un mensaje similar a:

```text
Hi z3nit-dev! You've successfully authenticated,
but GitHub does not provide shell access.
```

---

# 🔗 Cambiar un repositorio de HTTPS a SSH

Si el repositorio se clonó inicialmente mediante HTTPS:

```bash
git remote -v
```

podemos cambiar `origin`:

```bash
git remote set-url origin git@github-personal:z3nit-dev/dotfiles.git
```

Comprobar:

```bash
git remote -v
```

Debe aparecer:

```text
origin  git@github-personal:z3nit-dev/dotfiles.git (fetch)
origin  git@github-personal:z3nit-dev/dotfiles.git (push)
```

A partir de ese momento Git utilizará la identidad SSH personal.

---

# 👤 Identidad Git

El bootstrap conserva la identidad Git que ya exista antes de restaurar `.gitconfig`.

Comprobar:

```bash
git config --global user.name
git config --global user.email
```

Si no existe una identidad, `bootstrap.sh` la solicita durante la instalación.

La identidad global puede sobrescribirse individualmente en un proyecto:

```bash
git config user.name "Nombre"
git config user.email "email@example.com"
```

Esto permite mantener una identidad global profesional y utilizar otra identidad en proyectos concretos.

---

# 🔀 Compatibilidad entre versiones de Git

El entorno utiliza `zdiff3` cuando la versión de Git lo permite.

En versiones antiguas se utiliza:

```text
diff3
```

El bootstrap detecta la versión instalada automáticamente.

Esto es necesario porque, por ejemplo, Linux Mint 21.3 incluye Git 2.34.1, mientras que versiones más recientes de Git soportan `zdiff3`.

El archivo `git/gitconfig` no fuerza directamente esta opción para mantener compatibilidad entre distribuciones.

---

# 🧪 Comprobar la instalación

Después del bootstrap:

```bash
command -v zsh
command -v git
command -v node
command -v pnpm
command -v ng
command -v eza
command -v fastfetch
command -v delta
command -v oh-my-posh
command -v opencode
```

Comprobar versiones:

```bash
git --version
node --version
npm --version
pnpm --version
ng version
eza --version
fastfetch --version
delta --version
oh-my-posh version
opencode --version
```

Comprobar shell:

```bash
echo "$SHELL"
```

Comprobar Git:

```bash
git config --global --list
```

Comprobar SSH:

```bash
ssh -T git@github-personal
```

---

# 🧹 Qué NO se guarda en este repositorio

Este repositorio no pretende ser una copia completa del `$HOME`.

No se almacenan:

* claves privadas SSH;
* tokens;
* contraseñas;
* credenciales;
* historial del shell;
* caches;
* configuraciones específicas de una máquina;
* archivos personales;
* proyectos;
* `node_modules`;
* datos generados por aplicaciones.

La idea es almacenar **configuración reproducible**, no datos personales.

---

# 🔄 Actualizar el entorno

Para actualizar los dotfiles en una máquina existente:

```bash
cd ~/dotfiles
git pull --ff-only
```

Si se modifican los scripts de instalación, revisar primero los cambios:

```bash
git diff
```

Después puede ejecutarse de nuevo:

```bash
./bootstrap.sh
```

Los scripts intentan detectar herramientas ya instaladas y evitar trabajo innecesario.

---

# 🛠️ Modificar la configuración

Flujo recomendado:

```bash
cd ~/dotfiles
```

Editar el archivo correspondiente.

Por ejemplo:

```text
home/.zshrc
git/gitconfig
config/fastfetch/config.jsonc
config/oh-my-posh/unicorn.json
```

Comprobar los scripts:

```bash
for file in bootstrap.sh install/*.sh; do
    echo "==> $file"
    bash -n "$file" || exit 1
done
```

Comprobar el diff:

```bash
git diff --check
```

Revisar:

```bash
git diff
```

Después:

```bash
git add <archivos>
git commit -m "..."
git push
```

---

# 🧪 Validación antes de publicar cambios

Antes de hacer un commit:

### 1. Sintaxis

```bash
for file in bootstrap.sh install/*.sh; do
    echo "==> $file"
    bash -n "$file" || exit 1
done
```

### 2. Whitespace

```bash
git diff --check
```

### 3. Estado

```bash
git status
```

### 4. Cambios preparados

```bash
git diff --cached --stat
```

---

# 📋 Checklist para una máquina nueva

```text
[ ] Instalar Linux / WSL2
[ ] Instalar Git
[ ] Clonar ~/dotfiles
[ ] Ejecutar ./bootstrap.sh
[ ] Reiniciar la sesión de Zsh
[ ] Comprobar Node / pnpm / Angular
[ ] Comprobar herramientas externas
[ ] Generar claves SSH
[ ] Añadir claves públicas a GitHub
[ ] Probar ssh -T git@github-personal
[ ] Cambiar remotos HTTPS → SSH
[ ] Comprobar identidad Git
[ ] Comprobar configuración
[ ] Comenzar a trabajar
```

---

## 🔒 Principio fundamental

> **El repositorio contiene la receta para reconstruir el entorno, no las credenciales para acceder a él.**

Una máquina nueva debe poder reconstruirse instalando las herramientas y restaurando la configuración, mientras que las identidades, claves privadas y credenciales se crean o configuran de forma independiente en cada equipo.
