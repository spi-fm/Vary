/*
 * generated by Xtext
 */
package vary.pseudocodigo.dsl.c.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IGenerator
import org.eclipse.xtext.generator.IFileSystemAccess
import vary.pseudocodigo.dsl.c.generator.util.ReadFileProperties
import vary.pseudocodigo.dsl.c.generator.util.ProjectLocationFolder
import java.io.IOException
import diagramapseudocodigo.Codigo
import vary.pseudocodigo.dsl.c.generator.c.VaryGrammarGeneratorC
import vary.pseudocodigo.dsl.c.generator.cpp.VaryGrammarGeneratorCPP
import vary.pseudocodigo.dsl.c.validation.messages.ReadMessagesValidatorInterface
import com.google.inject.Inject
import vary.pseudocodigo.dsl.c.validation.messages.ReadMessagesValidator

/**
 * Generates code from your model files on save.
 * 
 * see http://www.eclipse.org/Xtext/documentation.html#TutorialCodeGeneration
 */
class VaryGrammarGenerator implements IGenerator {
	
	static ReadFileProperties readerFileProperties = new ReadFileProperties();
	protected final ReadMessagesValidatorInterface readerMessages;
	
	@Inject
	new() {
		readerMessages = new ReadMessagesValidator();
	}
	
	new(String lenguaje) {
		readerMessages = new vary.pseudocodigo.dsl.c.validation.english.messages.ReadMessagesValidator();
	}

	//EMap<String, TipoVariable> tablaSimbolos;
	override void doGenerate(Resource resource, IFileSystemAccess myCFile) {

		for (myPseudo : resource.allContents.toIterable.filter(typeof(Codigo))) {
			
			ProjectLocationFolder.setResource(resource);
			
			System.out.println("La uri cogida es:"+ProjectLocationFolder.getPath())
			var contenidoFichero = new String();
			
			try {
					
				if(ProjectLocationFolder.getOS().equals("WIN32")) {
					contenidoFichero = readerFileProperties.readFilePropertiesWindows(ProjectLocationFolder.getPath() + ".varyproject", 2);
				}
					
				else {
					contenidoFichero = readerFileProperties.readFilePropertiesUnix("file:"+ProjectLocationFolder.getPath(), 2);
				}
					
			} catch(IOException e) {
				e.printStackTrace();
			}
			
			//Recogemos la selección del lenguaje desde el fichero oculto
			
			var tipoProyecto = contenidoFichero.replaceAll("lenguajeGeneracion=","");
			
			
			if(tipoProyecto == "C") {
				var generadorC = new VaryGrammarGeneratorC(readerMessages)
				generadorC.doGenerate(resource, myCFile)
			}
			else {
				var generadorCPP = new VaryGrammarGeneratorCPP(readerMessages)
				generadorCPP.doGenerate(resource, myCFile)
			}
		}
	}
}
