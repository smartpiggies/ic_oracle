import type { Principal } from '@dfinity/principal';
export interface Price_Oracle {
  'addAdmin' : (arg_0: Principal) => Promise<undefined>,
  'addRecord' : (arg_0: string, arg_1: bigint) => Promise<undefined>,
  'checkAdmin' : () => Promise<boolean>,
  'getIndex' : () => Promise<bigint>,
  'getLatest' : () => Promise<bigint>,
  'getOwner' : () => Promise<string>,
  'getPrice' : (arg_0: bigint) => Promise<bigint>,
  'getRecord' : (arg_0: bigint) => Promise<[string, bigint, bigint]>,
  'removeAdmin' : (arg_0: Principal) => Promise<undefined>,
}
export interface _SERVICE extends Price_Oracle {}
