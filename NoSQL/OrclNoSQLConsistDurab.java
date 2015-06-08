/*
	** Codigo sin validar
	** Consistencia y Durabilidad **
*/

Durability defaultDurability = new Durability(
												Durability.SyncPolicy.SYNC, // Master
												Durability.SyncPolicy.NO_SYNC, //Replica
												Durability.ReplicaAckPolicy.SIMPLE_MAJORITY
											);
											
/*
	Crea una instancia de la clase KVStoreConfig especificando el nombre del store, y una máquina del cluster
*/
KVStoreConfig conf = new KVStoreConfig("kvstore", "maquina:5000");
conf.setDurability(defaultDurability);
conf.setConsistency(consistency.NONE_REQUIRED);
store = KVStoreFactory.getStore(conf);

/*
Crea e inserta un registro en el store basado en un a nueva politica de durabilidad que sobre-escribe la default
*/
majorList.add("users");
majorList.add("usersId");
majorList.add("folders");

minorList.add("notepad");

Key myKey = Key.createKey(majorList, minorList);
String content = "Una prueba solamente";
Value myValue = Value.createValue(st.getBytes());

Durability durability = new Durability(
										Durability.SyncPolicy.NO_SYNC, // Master
										Durability.SyncPolicy.NO_SYNC, //Replica
										Durability.ReplicaAckPolicy.NONE
										);
try {
	store.put(myKey, myValue, null, durability, 0, null);
} catch (DurabilityException de) {
	de.printStackTrace();
} catch (RequestTimeoutException re) {
	re.printStackTrace();
}

ValueVersion vv = store.get(myKey, Consistency.ABSOLUTE, 0, null);