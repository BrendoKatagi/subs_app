enum Role {
  admin,
  user,
  partner,
  merchant,
  none;

  static Role byFkRole(int fkRole) => Role.values.elementAt(fkRole - 1);
}
