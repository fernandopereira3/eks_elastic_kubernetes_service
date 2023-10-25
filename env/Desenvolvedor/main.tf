module "dev" {
  source = "../../infra"
  cluster = "dev"
  nome_repositorio = "dev"
  cargoIAM = "dev"
  ambiente = "dev"
}