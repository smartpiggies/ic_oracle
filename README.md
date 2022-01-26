# User Controlled Price Oracle
Internet Computer repo for a user controlled price oracle

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
