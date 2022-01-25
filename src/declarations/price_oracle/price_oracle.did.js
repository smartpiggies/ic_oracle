export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'addRecord' : IDL.Func([IDL.Text, IDL.Int64], [], []),
    'getIndex' : IDL.Func([], [IDL.Int], []),
    'getLatest' : IDL.Func([], [IDL.Int64], []),
    'getPrice' : IDL.Func([IDL.Int], [IDL.Int64], []),
    'getRecord' : IDL.Func([IDL.Nat], [IDL.Text, IDL.Int64, IDL.Int], []),
  });
};
export const init = ({ IDL }) => { return []; };
