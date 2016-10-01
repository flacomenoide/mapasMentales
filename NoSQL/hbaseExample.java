Configuration conf = HBaseConfiguration.create();
Connection connection = ConnectionFactory.createConnection(conf);
Admin admin = connection.getAdmin();
...
TableName[] tables = admin.listTableNames();
...
admin.close();
connection.close();



NamespaceDescriptor.Builder builder = NamespaceDescriptor.create("testspace");
builder.addConfiguration("key1", "value1");
NamespaceDescriptor desc = builder.build();
System.out.println("Namespace: " + desc);

private static void print(String tablename) {
    print(null, tablename);
  }

  private static void print(String namespace, String tablename) {
    System.out.print("Given Namespace: " + namespace +
      ", Tablename: " + tablename + " -> ");
    try {
      System.out.println(namespace != null ?
        TableName.valueOf(namespace, tablename) :
        TableName.valueOf(tablename));
    } catch (Exception e) {
      System.out.println(e.getClass().getSimpleName() +
        ": " + e.getMessage());
    }
  }

  public static void main(String[] args) throws IOException, InterruptedException {
    print("testtable");
    print("testspace:testtable");
    print("testspace", "testtable");
    print("testspace", "te_st-ta.ble");
    print("", "TestTable-100");
    print("tEsTsPaCe", "te_st-table");

    print("");

    // VALID_NAMESPACE_REGEX = "(?:[a-zA-Z_0-9]+)";
    // VALID_TABLE_QUALIFIER_REGEX = "(?:[a-zA-Z_0-9][a-zA-Z_0-9-.]*)";
    print(".testtable");
    print("te_st-space", "te_st-table");
    print("tEsTsPaCe", "te_st-table@dev");
  }

Configuration conf = HBaseConfiguration.create();
Connection connection = ConnectionFactory.createConnection(conf);
TableName tn = TableName.valueOf(tableName);
RegionLocator locator = connection.getRegionLocator(tn);
Pair<byte[][], byte[][]> pair = locator.getStartEndKeys();
...
locator.close();

 HColumnDescriptor desc = new HColumnDescriptor("colfam1")
      .setValue("test-key", "test-value")
      .setBloomFilterType(BloomType.ROWCOL);

    System.out.println("Column Descriptor: " + desc);

    System.out.print("Values: ");
    for (Map.Entry<ImmutableBytesWritable, ImmutableBytesWritable>
      entry : desc.getValues().entrySet()) {
      System.out.print(Bytes.toString(entry.getKey().get()) +
        " -> " + Bytes.toString(entry.getValue().get()) + ", ");
    }
    System.out.println();

    System.out.println("Defaults: " +
      HColumnDescriptor.getDefaultValues());

    System.out.println("Custom: " +
      desc.toStringCustomizedValues());

    System.out.println("Units:");
    System.out.println(HColumnDescriptor.TTL + " -> " +
      desc.getUnit(HColumnDescriptor.TTL));
    System.out.println(HColumnDescriptor.BLOCKSIZE + " -> " +
      desc.getUnit(HColumnDescriptor.BLOCKSIZE));
