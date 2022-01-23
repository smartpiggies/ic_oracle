export const idlFactory = ({ IDL }) => {
  return IDL.Service({ 'addRecord' : IDL.Func([IDL.Text, IDL.Int64], [], []) });
};
export const init = ({ IDL }) => { return []; };
