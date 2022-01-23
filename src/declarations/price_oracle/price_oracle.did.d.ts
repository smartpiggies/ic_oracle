import type { Principal } from '@dfinity/principal';
export interface _SERVICE {
  'addRecord' : (arg_0: string, arg_1: bigint) => Promise<undefined>,
  'getIndex' : () => Promise<bigint>,
  'getLatest' : () => Promise<bigint>,
  'getPrice' : (arg_0: bigint) => Promise<bigint>,
}
