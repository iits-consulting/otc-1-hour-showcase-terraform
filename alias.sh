alias createVaultToken='unset VAULT_TOKEN && vault login -method=oidc -path=keycloak role=admin && sudo sh -c "echo VAULT_TOKEN=$(cat ~/.vault-token) >> /etc/environment" && sudo sh -c "echo TF_VAR_vault_token=$(cat ~/.vault-token) >> /etc/environment" && source /etc/environment'

function kube() {
        vault kv get -format=table -field=kubectl_config secret/$1/kubectl | base64 -d > ~/.kube/config && kubeEnv
}

function cloudGOTC() {
        export VAULT_ADDR="REPLACE_ME"
        createVaultToken
        export ACCESS_KEY=$(vault kv get --field access_key secret/otc_credentials/$1)
        export SECRET_KEY=$(vault kv get --field secret_key secret/otc_credentials/$1)
        export AWS_ACCESS_KEY_ID=$ACCESS_KEY
        export AWS_SECRET_ACCESS_KEY=$SECRET_KEY
}