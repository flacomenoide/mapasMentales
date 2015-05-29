/*
	*** Codigo de referencia, NO Validado ***
	Ejemplo de escritura y lectura de un registro
*/

/* Paquete para que pueda ser reutilizado */
package helloToNOSQLOrcl;

/* Clases importadas desde oracle.kv */
import oracle.kv.KVStore;
import oracle.kv.KVStoreConfig;
import oracle.kv.KVStoreFactory;
import oracle.kv.Key;
import oracle.kv.Value;
import oracle.kv.ValueVersion;

/* Clase publica para que pueda ser accedida */
public class HelloNOSQLWorld {
	
	/* Esta variable nos ayuda a manejar la comunicación con la DB */
	private final KVStore store;
	
	public static void main(String args[]) {
		try {
		
			/* Crea una instancia de la clase HelloNOSQLWorld */
			HelloNOSQLWorld ejemplo = new HelloNOSQLWorld (args);

			/* Ejecuta el metodo runExample */
			ejemplo.runExample();
			
		} catch (RuntimeException e) {
			e.printStackTrace();
		}
	}
	
	/*
	   - Parsea la linea de comando
	   - Abre el store clave-valor
	*/
	HelloBigDataWorld(String[] argv) {
		String storeName = "kvstore";
		String hostName = "localhost";
		String hostPort = "5000";
		
		final int nArgs = argv.length;
		int argc = 0;
		
		while (argc < nArgs) {
			final String thisArg = argv[argc++];
			
			if (thisArg.equals("-store")) {
				if (argc < nArgs) {
					storeName = argv[argc++];
				} else {
					usage("-store requiere un argumento");
				}
			} else if (thisArg.equals("-host")) {
				if (argc < nArgs) {
					hostName = argv[argc++];
				} else {
					usage("-host requiere un argumento");
				}
			} else if (thisArg.equals("-port")) {
				if (argc < nArgs) {
					hostPort = argv[argc++];
				} else {
					usage("-port requiere un argumento");
				}
			} else {
				usage("argumento desconocido: " + this);
			}
		}
		store = KVStoreFactory.getStore(new KVStoreConfig(storeName, hostName + ":" + hostPort));
	}
	
	/* Imprime las formas como la clase HelloNOSQLWorld puede ser usada */
	private void usage(String mensaje) {
		System.out.println("\n" + mensaje + "\n");
		System.out.println("uso: HelloBigDataWorld ");
		System.out.println("\t-store <nombre instancia> (default: kvstore) " +
						   "-host <nombre del host> (default: localhost) " +
						   "-port <numero de puerto> (default: 5000)");
		System.exit(1);
	}
	
	void runExample() {
		final String keyString = "/Hello";
		final String valueString = "NoSQL World!";
		
		/* Escribe un registro en la DB */
		store.put(Key.fromString(keyString), Value.createValue(valueString.getBytes()));
		
		/* Lee el registro insertado previamente */
		final ValueVersion valueVersion = store.get(Key.fromString(keyString));
		
		System.out.println(keyString + " " + new String(valueVersion.getValue().getValue()));
		store.close();
	}
}