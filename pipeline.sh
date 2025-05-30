#!/bin/bash

# Setup inicial

set -e

export AWS_ACCOUNT = "var"

# Função para exibir mensagens de erro e sair
error_exit() {
    echo -e "${RED}Erro: $1${NC}" >&2
    exit 1
}

# Função para verificar resultado do último comando
check_result() {
    if [ $? -ne 0 ]; then
        error_exit "$1"
    fi
}

# Verificar se o Terraform está instalado
if ! command -v terraform &> /dev/null; then
    error_exit "Terraform não está instalado. Por favor, instale primeiro."
fi

# Verificar se as credenciais AWS estão configuradas
if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ] || [ -z "$AWS_REGION" ]; then
    error_exit "Credenciais AWS não configuradas. Configure as variáveis de ambiente AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY e AWS_REGION"
fi

echo -e "${YELLOW}Iniciando deploy de infraestrutura AWS...${NC}"

# Inicializar Terraform
echo -e "${GREEN}Inicializando Terraform...${NC}"
terraform init
check_result "Falha ao inicializar Terraform"

# Verificar formatação
echo -e "${GREEN}Verificando formatação...${NC}"
terraform fmt -check
check_result "Verificação de formatação falhou"

# Validar configuração
echo -e "${GREEN}Validando configuração...${NC}"
terraform validate
check_result "Validação falhou"

# Criar plano
echo -e "${GREEN}Criando plano de execução...${NC}"
terraform plan -out=tfplan
check_result "Falha ao criar plano"

# Perguntar se deseja prosseguir com o apply
echo -e "${YELLOW}Deseja prosseguir com o deploy? (s/N)${NC}"
read -r resposta

if [[ "$resposta" =~ ^[Ss]$ ]]; then
    echo -e "${GREEN}Aplicando mudanças...${NC}"
    terraform apply tfplan
    check_result "Falha ao aplicar mudanças"
    
    echo -e "${GREEN}Deploy concluído com sucesso!${NC}"
else
    echo -e "${YELLOW}Deploy cancelado pelo usuário.${NC}"
    rm tfplan
    exit 0
fi

# Limpar arquivos temporários
rm tfplan
