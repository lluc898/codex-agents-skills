# Codex agents and skills

Backup privado de los agentes y skills personalizados instalados globalmente.

## Contenido

- `agents/`: agentes globales de `~/.codex/agents`.
- `skills/codex/`: skills personalizadas de `~/.codex/skills`, excluyendo `.system`.
- `skills/user/`: skills personalizadas de `~/.agents/skills`.
- `scripts/sync-from-global.ps1`: actualiza este repositorio desde la instalación activa.
- `scripts/install-global.ps1`: restaura las copias en otra instalación local.

Las rutas absolutas del perfil de Windows se guardan como `__USER_PROFILE__` en los agentes y se reconstruyen al instalar.

## Guardar cambios futuros

Desde PowerShell, dentro del repositorio:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\sync-from-global.ps1
git status
git add .
git commit -m "Update agents and skills"
git push
```

El script sincroniza archivos nuevos o modificados. No elimina automáticamente copias antiguas del repositorio; revisa `git status` y elimina manualmente solo aquello que hayas retirado de forma intencionada.

## Restaurar en otra instalación

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\install-global.ps1
```

Por seguridad, el instalador no sobrescribe archivos existentes. Para actualizar una instalación existente:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\install-global.ps1 -Force
```

Reinicia Codex o abre una sesión nueva para que vuelva a descubrir los agentes y skills.

## Exclusiones

Este repositorio no incluye:

- Skills internas de `~/.codex/skills/.system`.
- Plugins y cachés descargadas por Codex.
- `config.toml`, credenciales, tokens, historiales o datos de sesión.
