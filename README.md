# User Controlled Price Oracle
Internet Computer repo for a user controlled price oracle

![Oracle Diagram](./media/Oracle_Diagram.jpg)

* clone repo
* cd into repo
* run `npm install`
* run `dfx start` (in another terminal or background)
* run `dfx deploy`
* test with `dfx canister call price_oracle greet "[name]"`

view the Candid UI with:

http://localhost:8000/?canisterId=<candid-id>&id=<canister-id>

for example:

http://127.0.0.1:8000/?canisterId=r7inp-6aaaa-aaaaa-aaabq-cai&id=rrkah-fqaaa-aaaaa-aaaaq-cai

id found in `.dfx/local/canister_ids.json` or with:

`dfx canister id __Candid_UI`

and

`dfx canister id <caniser name, i.e. price_oracle>`

upgrading the canister:

`dfx deploy`

or

`dfx canister install --mode=upgrade --all`

Records can be queried from the Candid UI

However, records can only be added with an authenticated user:

`dfx canister --wallet=$(dfx identity get-wallet) call price_oracle addRecord '("20220123", 2057)'`

## Adding records with an admin (locally):

Steps for creating a new identity and adding it as an admin:

`dfx identity new ic_admin`

`dfx use identity ic_admin`

`dfx identity get-principal`

`dfx use identity default`

`dfx canister —wallet=$(dfx identity get-wallet) call price_oracle setAdmin ‘(principal “<principal from ic_admin>”)’`

`dfx —identity ic_admin canister call price_oracle checkAdmin`

`dfx —identity ic_admin canister call price_oracle addRecord ‘(“20220124”,2062)’`

`dfx identity list`

`dfx identity remove ic_admin`

## Deployment

`dfx canister --network=ic create --all`

`dfx canister build --check --network=ic`

`dfx canister --network=ic install --all`

deployed to canister id: `lkvnh-zyaaa-aaaai-qfl2q-cai`

`dfx canister --network=ic --wallet=$(dfx identity --network=ic get-wallet) call price_oracle addRecord '("20221023",2057)'`

## Costs

Failed added record: 10 938 cycles

Successful added record: 3 102 327 cycles

Read record: 54 690 cycles
