/*
	*** Código de referencia, NO Validado ***
	Diferentes maneras de crear una clave y almacenar su valor
*/
String notePadKey = "/users/342717/folders/-/notepad"; 	/* la porcion menor de la clave es opcional (despues de -) */
String valueString = "item de prueba que no significa nada";
KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", host + ":" + port));

Key myKey = Key.fromString(notepadKey);

System.out.println(myKey.getFullPath());

System.out.println(myKey.toString());

Value myValue = Value.createValue(valueString.getBytes());

store.put(myKey, myValue);