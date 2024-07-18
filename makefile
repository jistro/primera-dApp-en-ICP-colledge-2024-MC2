.PHONY: startTestnet deployBackend getDidBackend help

help:
	@echo "startTestnet: inicia la testnet local de ICP"
	@echo "deployBackend: despliega el backend en la testnet local"
	@echo "getDidBackend: obtiene el candid del backend"

testnet:
	dfx start --clean

backend:
	dfx deploy mc2_backend

deploy:
	dfx deploy

getDidBackend:
	@dfx canister create mc2_backend
	@dfx build mc2_backend
	@echo "El candid del backend esta ubicado en ./.dfx/local/canisters/mc2_backend"