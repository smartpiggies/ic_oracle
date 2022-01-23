export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'addRecord' : IDL.Func([IDL.Text, IDL.Int64], [], []),
    'getIndex' : IDL.Func([], [IDL.Int], []),
    'getPrice' : IDL.Func([IDL.Int], [IDL.Int64], []),
  });
};
export const init = ({ IDL }) => { return []; };
