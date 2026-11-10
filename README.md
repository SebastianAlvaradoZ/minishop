# MiniShop REST API

![CI](https://github.com/SebastianAlvaradoZ/minishop/actions/workflows/ci.yml/badge.svg)

API REST de productos construida con Spring Boot, Spring Data JPA y H2.

## Pruebas

| Tipo | Plugin | Clases | Comando |
|------|--------|--------|---------|
| Unitarias | Surefire | `*Test` | `mvn test` |
| Integración | Failsafe | `*IT` | `mvn verify` |

El pipeline de GitHub Actions (`.github/workflows/ci.yml`) compila, ejecuta las pruebas unitarias y de integración por separado con cada push y Pull Request a `main`, y publica una Release con el `.jar` al crear una etiqueta `v*`.
