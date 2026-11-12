# NAFISA AI: Phase 1 + 2 (backend and web dashboard)

Status: source written, **not yet run**. It was authored in a sandbox without internet, so nothing here has been executed against real services. First run on Replit may need small fixes. Send me the errors.

## Run on Replit
1. Create a Repl (Import / upload this folder). Add the **PostgreSQL** tool (sets `DATABASE_URL`).
2. Tools > Secrets: add `JWT_SECRET` and `ENCRYPTION_KEY` (see `.env.template` for generation commands). Keep the same `ENCRYPTION_KEY` forever, or stored API keys become unreadable.
3. Press Run. `start.sh` installs Python deps, builds the React app, starts FastAPI on port 8000.
4. Open the app, create your account, then set `ALLOW_REGISTRATION=false` in Secrets.
5. Providers tab: add a Gemini key (aistudio.google.com) > it tests the key, discovers models, picks a default. Chat in Bengali or English.
6. API docs: `/docs`. Health: `/api/health`.
7. Deploy: Replit Deployments (config in `.replit`). HTTPS is provided by Replit.

## What works in this phase
- Auth (bcrypt, JWT), per-IP rate limiting on auth/chat/providers, audit log (`/api/auth/audit`)
- Provider manager: Gemini, OpenAI, Anthropic, DeepSeek, Groq, OpenRouter, Mistral, custom OpenAI-compatible; model discovery, default model, enable/disable, status, streaming, rate-limit/error handling
- API keys Fernet-encrypted at rest, never returned (only last 4 chars)
- Custom provider URLs: https only, private/loopback addresses blocked (SSRF)
- Conversations (stored, searchable via `?q=`, deletable) and Private mode (nothing stored)
- Device registration with revocable tokens; WebSocket sync channel (`/ws`, first message authenticates)
- Dashboard: glass/holographic UI, animated core, chat, providers, devices

## Known limits (honest list)
- Per-task model routing, memory system, Theme Studio, voice, search, task engine, Android, Windows: later phases
- Rate limiter is in-memory (single instance); no DB migrations yet (tables auto-created); JWT stored in localStorage
- Device tokens currently have the same API scope as user tokens; scoping comes with the Android phase
- No automated tests yet
