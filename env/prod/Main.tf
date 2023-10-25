module "prod" {
  source = "../../infra"
  cluster = "producao"
  nome_repositorio = "producao"
  cargoIAM = "producao"
  ambiente = "producao"
}

# output "saida" {
#   value = module.prod.url
# }