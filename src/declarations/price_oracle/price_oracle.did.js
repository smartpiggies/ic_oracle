export const idlFactory = ({ IDL }) => {
  const Price_Oracle = IDL.Service({
    'addAdmin' : IDL.Func([IDL.Principal], [], []),
    'addRecord' : IDL.Func([IDL.Text, IDL.Int64], [], []),
    'checkAdmin' : IDL.Func([], [IDL.Bool], []),
    'getIndex' : IDL.Func([], [IDL.Int], []),
    'getLatest' : IDL.Func([], [IDL.Int64], []),
    'getOwner' : IDL.Func([], [IDL.Text], []),
    'getPrice' : IDL.Func([IDL.Int], [IDL.Int64], []),
    'getRecord' : IDL.Func([IDL.Nat], [IDL.Text, IDL.Int64, IDL.Int], []),
    'removeAdmin' : IDL.Func([IDL.Principal], [], []),
  });
  return Price_Oracle;
};
export const init = ({ IDL }) => { return []; };
