/*
 * generated by Xtext
 */
package vary.pseudocodigo.dsl.c.ui.contentassist

import vary.pseudocodigo.dsl.c.ui.contentassist.AbstractVaryGrammarProposalProvider
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.CrossReference
import org.eclipse.xtext.Assignment
import org.eclipse.xtext.ui.editor.contentassist.ContentAssistContext
import org.eclipse.xtext.ui.editor.contentassist.ICompletionProposalAcceptor
import diagramapseudocodigo.Modulo
import org.eclipse.jface.viewers.StyledString
import diagramapseudocodigo.Variable
import diagramapseudocodigo.Declaracion
import diagramapseudocodigo.DeclaracionVariable
import diagramapseudocodigo.DeclaracionPropia
import org.eclipse.xtext.RuleCall
import org.eclipse.xtext.Group
import diagramapseudocodigo.VariableID
import org.eclipse.xtext.EcoreUtil2
import diagramapseudocodigo.Algoritmo
import diagramapseudocodigo.Vector
import diagramapseudocodigo.Matriz
import diagramapseudocodigo.Registro
import diagramapseudocodigo.Enumerado
import diagramapseudocodigo.Subrango
import diagramapseudocodigo.Archivo
import java.util.List
import diagramapseudocodigo.TipoComplejo
import diagramapseudocodigo.Subproceso
import diagramapseudocodigo.Procedimiento
import diagramapseudocodigo.Funcion
import diagramapseudocodigo.AsignacionNormal
import javax.imageio.ImageIO
import diagramapseudocodigo.ParametroFuncion
import diagramapseudocodigo.LlamadaFuncion
import diagramapseudocodigo.ValorRegistro

/**
 * see http://www.eclipse.org/Xtext/documentation.html#contentAssist on how to customize content assistant
 */
class VaryGrammarProposalProvider extends AbstractVaryGrammarProposalProvider {
	
	override getStyledDisplayString(EObject element, String qualifiedNameAsString, String shortName) {
		if (element instanceof Modulo) {
			new StyledString("Modulo :: " + shortName,StyledString::QUALIFIER_STYLER)
		if (element instanceof Variable) {
			var variable = element as Variable
			var dec = variable.eContainer() as Declaracion
			if(dec instanceof DeclaracionVariable) {
				var decVar = dec as DeclaracionVariable
				new StyledString("Variable :: " + shortName + " Tipo::" + decVar.tipo.name,StyledString::QUALIFIER_STYLER)
			}
			if(dec instanceof DeclaracionPropia) {
				var decPropia = dec as DeclaracionPropia
				new StyledString("Variable :: " + shortName + " Tipo::" + decPropia.tipo,StyledString::QUALIFIER_STYLER)
			}
		}
		} else
			super.getStyledDisplayString(element, qualifiedNameAsString, shortName)
	}
	
	//Proposal para las variables definidas con un tipo personalizado -----------------------------------------------------
	override void completeDeclaracionPropia_Tipo(EObject model, Assignment assignment, ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		
		if(context.getRootModel instanceof Algoritmo) {
			var algoritmo = context.getRootModel() as Algoritmo;
			//Cogemos todos los tipos
			completeDeclaracionPropia_TipoAux(context, acceptor, algoritmo.tipocomplejo)
		}
		else if(context.getRootModel instanceof Modulo) {
			var modulo = context.getRootModel() as Modulo;
			//Cogemos todos los tipos
			completeDeclaracionPropia_TipoAux(context, acceptor, modulo.implementacion.tipocomplejo)
		}
	}
	
	def void completeDeclaracionPropia_TipoAux(ContentAssistContext context, ICompletionProposalAcceptor acceptor, List<TipoComplejo> complejos) {
		for(tipo: complejos) {
			if(tipo instanceof Vector) {
				var vector = tipo as Vector
				//Creamos un nuevo proposal
				var completionProposal = createCompletionProposal(vector.nombre, context);
				acceptor.accept(completionProposal);
			}
			else if(tipo instanceof Matriz) {
				var matriz = tipo as Matriz
				var completionProposal = createCompletionProposal(matriz.nombre, context);
				acceptor.accept(completionProposal);
			}
			else if(tipo instanceof Registro) {
				var registro = tipo as Registro
				var completionProposal = createCompletionProposal(registro.nombre, context);
				acceptor.accept(completionProposal);
			}
			else if(tipo instanceof Enumerado) {
				var enumerado = tipo as Enumerado
				var completionProposal = createCompletionProposal(enumerado.nombre, context);
				acceptor.accept(completionProposal);
			}
			else if(tipo instanceof Subrango) {
				var subrango = tipo as Subrango
				var completionProposal = createCompletionProposal(subrango.nombre, context);
				acceptor.accept(completionProposal);
			}
			else if(tipo instanceof Archivo) {
				var archivo = tipo as Archivo
				var completionProposal = createCompletionProposal(archivo.nombre, context);
				acceptor.accept(completionProposal);
			}
		}
	}
	//Proposal para las variables definidas con un tipo nativo ------------------------------------------------------------
	override void completeDeclaracionVariable_Tipo(EObject model, Assignment assignment, ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		if(context.getRootModel instanceof Algoritmo) {
			var algoritmo = context.getRootModel() as Algoritmo;
			//Cogemos todos los tipos
			completeDeclaracionVariable_TipoAux(context, acceptor)
		}
		else if(context.getRootModel instanceof Modulo) {
			var modulo = context.getRootModel() as Modulo;
			//Cogemos todos los tipos
			completeDeclaracionVariable_TipoAux(context, acceptor)
		}
	}
	
	def void completeDeclaracionVariable_TipoAux(ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		//Añadimos todas las propuestas con los tipos nativos posibles
		var completionProposal = createCompletionProposal("entero", context)
		acceptor.accept(completionProposal)
		completionProposal = createCompletionProposal("real", context)
		acceptor.accept(completionProposal)
		completionProposal = createCompletionProposal("logico", context)
		acceptor.accept(completionProposal)
		completionProposal = createCompletionProposal("caracter", context)
		acceptor.accept(completionProposal)
		completionProposal = createCompletionProposal("cadena", context)
		acceptor.accept(completionProposal)
	}
	
	//Proposal para las variableID en las asignacionesNormal---------------------------------------------------------------
	override void completeAsignacionNormal_Operador(EObject model, Assignment assignment, ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		if(context.getRootModel instanceof Algoritmo) {
			//Recogemos la sentencia para buscar si pertenece a un Subproceso
			var asignacionNormal = context.currentModel as AsignacionNormal
			var procedimiento = EcoreUtil2.getContainerOfType(asignacionNormal, Procedimiento)
			var funcion = EcoreUtil2.getContainerOfType(asignacionNormal, Funcion)
			var algoritmo = context.getRootModel() as Algoritmo;
			completeAsignacionNormal_OperadorAux(context, acceptor, algoritmo.global)
			
			if(procedimiento == null && funcion == null) {
				//Si los dos son nulos pertenece a Inicio
				completeAsignacionNormal_OperadorAux(context, acceptor, algoritmo.tiene.declaracion)
			}
			else {
				if(procedimiento != null) {
					completeAsignacionNormal_OperadorAux(context, acceptor, procedimiento.declaracion)
					completeAsignacionNormal_OperadorParametrosSubproceso(context, acceptor, procedimiento.parametrofuncion)
					
				}
				else if(funcion != null) {
					completeAsignacionNormal_OperadorAux(context, acceptor, funcion.declaracion)
					completeAsignacionNormal_OperadorParametrosSubproceso(context, acceptor, funcion.parametrofuncion)
				}
			}
			
		}
		else if(context.getRootModel instanceof Modulo) {
			//Recogemos la sentencia para buscar si pertenece a un Subproceso
			var asignacionNormal = context.currentModel as AsignacionNormal
			var procedimiento = EcoreUtil2.getContainerOfType(asignacionNormal, Procedimiento)
			var funcion = EcoreUtil2.getContainerOfType(asignacionNormal, Funcion)
			var modulo = context.getRootModel() as Modulo
			completeAsignacionNormal_OperadorAux(context, acceptor, modulo.implementacion.global)
			
			if(procedimiento != null) {
				completeAsignacionNormal_OperadorAux(context, acceptor, procedimiento.declaracion)
				completeAsignacionNormal_OperadorParametrosSubproceso(context, acceptor, procedimiento.parametrofuncion)
			}
			else if(funcion != null) {
				completeAsignacionNormal_OperadorAux(context, acceptor, funcion.declaracion)
				completeAsignacionNormal_OperadorParametrosSubproceso(context, acceptor, funcion.parametrofuncion)
			}
		}
	}
	
	def completeAsignacionNormal_OperadorParametrosSubproceso(ContentAssistContext context, ICompletionProposalAcceptor acceptor, List<ParametroFuncion> parametros) {
		for(ParametroFuncion parametro: parametros) {
			var completionProposal = createCompletionProposal(parametro.variable.nombre, context)
			acceptor.accept(completionProposal)
		}
	}
	
	def completeAsignacionNormal_OperadorAux(ContentAssistContext context, ICompletionProposalAcceptor acceptor, List<Declaracion> declaraciones) {
		for(Declaracion declaracion: declaraciones) {
			if(declaracion instanceof DeclaracionPropia) {
				var dec = declaracion as DeclaracionPropia
				for(Variable v: dec.variable) {
					var completionProposal = createCompletionProposal(v.nombre, context)
					acceptor.accept(completionProposal)
				}
			}
			else if(declaracion instanceof DeclaracionVariable) {
				var dec = declaracion as DeclaracionVariable
				for(Variable v: dec.variable) {
					var completionProposal = createCompletionProposal(v.nombre, context)
					acceptor.accept(completionProposal)
				}
			}
		}
	}
	
	//Proposal para las llamadas a funciones ------------------------------------------------------------------------------
	
	override void completeInicio_Tiene(EObject model, Assignment assignment, ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		var algoritmo = context.getRootModel() as Algoritmo
		for(Subproceso s: algoritmo.funcion) {
			if(s instanceof Procedimiento) {
				//Sólo los procedimientos porque son los que no devuelven nada
				var procedimiento = s as Procedimiento
				completeInicio_TieneAux(context, acceptor, procedimiento.nombre, procedimiento.parametrofuncion)
			}
		}
	}
	
	override void completeProcedimiento_Sentencias(EObject model, Assignment assignment, ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		if(context.getRootModel instanceof Algoritmo) {
			var algoritmo = context.getRootModel as Algoritmo
			for(Subproceso s: algoritmo.funcion) {
				if(s instanceof Procedimiento) {
					//Sólo los procedimientos porque son los que no devuelven nada
					var procedimiento = s as Procedimiento
					completeInicio_TieneAux(context, acceptor, procedimiento.nombre, procedimiento.parametrofuncion)
				}
			}
		}
		else if(context.getRootModel instanceof Modulo) {
			var modulo = context.getRootModel as Modulo
			for(Subproceso s: modulo.implementacion.funcion) {
				//Sólo los procedimientos porque son los que no devuelven nada
				var procedimiento = s as Procedimiento
				completeInicio_TieneAux(context, acceptor, procedimiento.nombre, procedimiento.parametrofuncion)
			}
		}
			
	}
	
	override void completeFuncion_Sentencias(EObject model, Assignment assignment, ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		if(context.getRootModel instanceof Algoritmo) {
			var algoritmo = context.getRootModel as Algoritmo
			for(Subproceso s: algoritmo.funcion) {
				if(s instanceof Procedimiento) {
					//Sólo los procedimientos porque son los que no devuelven nada
					var procedimiento = s as Procedimiento
					completeInicio_TieneAux(context, acceptor, procedimiento.nombre, procedimiento.parametrofuncion)
				}
			}
		}
		else if(context.getRootModel instanceof Modulo) {
			var modulo = context.getRootModel as Modulo
			for(Subproceso s: modulo.implementacion.funcion) {
				//Sólo los procedimientos porque son los que no devuelven nada
				var procedimiento = s as Procedimiento
				completeInicio_TieneAux(context, acceptor, procedimiento.nombre, procedimiento.parametrofuncion)
			}
		}
	}
	
	def void completeInicio_TieneAux(ContentAssistContext context, ICompletionProposalAcceptor acceptor, String nombre, List<ParametroFuncion> parametros) {
		var valorProposal = nombre + "("
		if(parametros.size == 0) {
			valorProposal = valorProposal + ")"
		}
		else {
			for(ParametroFuncion p: parametros) {
				if(parametros.indexOf(p) != parametros.size - 1) {
					valorProposal = valorProposal + p.variable.nombre + ","
				}
				else {
					valorProposal = valorProposal + p.variable.nombre + ")"
				}
			}
		}
		var completionProposal = createCompletionProposal(valorProposal , context)
		acceptor.accept(completionProposal)
	}
	
	//Proposal para los parametros de las llamadas a funciones y procedimientos -------------------------------------------
	
	override void completeFunciones_Operadores(EObject model, Assignment assignment, ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		if(context.getRootModel instanceof Algoritmo) {
			var llamadaFuncion = context.currentModel as LlamadaFuncion
			var procedimiento = EcoreUtil2.getContainerOfType(llamadaFuncion, Procedimiento)
			var funcion = EcoreUtil2.getContainerOfType(llamadaFuncion, Funcion)
			var algoritmo = context.getRootModel() as Algoritmo;
			completeAsignacionNormal_OperadorAux(context, acceptor, algoritmo.global)
			
			if(procedimiento == null && funcion == null) {
				//Si los dos son nulos pertenece a Inicio
				completeAsignacionNormal_OperadorAux(context, acceptor, algoritmo.tiene.declaracion)
			}
			else {
				if(procedimiento != null) {
					completeAsignacionNormal_OperadorAux(context, acceptor, procedimiento.declaracion)
					completeAsignacionNormal_OperadorParametrosSubproceso(context, acceptor, procedimiento.parametrofuncion)
					
				}
				else if(funcion != null) {
					completeAsignacionNormal_OperadorAux(context, acceptor, funcion.declaracion)
					completeAsignacionNormal_OperadorParametrosSubproceso(context, acceptor, funcion.parametrofuncion)
				}
			}
			
		}
		else if(context.getRootModel instanceof Modulo) {
			//Recogemos la sentencia para buscar si pertenece a un Subproceso
			var llamadaFuncion = context.currentModel as LlamadaFuncion
			var procedimiento = EcoreUtil2.getContainerOfType(llamadaFuncion, Procedimiento)
			var funcion = EcoreUtil2.getContainerOfType(llamadaFuncion, Funcion)
			var modulo = context.getRootModel() as Modulo
			completeAsignacionNormal_OperadorAux(context, acceptor, modulo.implementacion.global)
			
			if(procedimiento != null) {
				completeAsignacionNormal_OperadorAux(context, acceptor, procedimiento.declaracion)
				completeAsignacionNormal_OperadorParametrosSubproceso(context, acceptor, procedimiento.parametrofuncion)
			}
			else if(funcion != null) {
				completeAsignacionNormal_OperadorAux(context, acceptor, funcion.declaracion)
				completeAsignacionNormal_OperadorParametrosSubproceso(context, acceptor, funcion.parametrofuncion)
			}
			
		}
	}
	
	//Proposal para los campos de un registro -----------------------------------------------------------------------------
	
	override void completeCampoRegistro_Nombre_campo(EObject model, Assignment assignment, ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		if(context.getRootModel instanceof Algoritmo) {
			var valorRegistro = context.getCurrentModel as ValorRegistro
			var procedimiento = EcoreUtil2.getContainerOfType(valorRegistro, Procedimiento)
			var funcion = EcoreUtil2.getContainerOfType(valorRegistro, Funcion)
			var algoritmo = context.getRootModel as Algoritmo
			
			if(procedimiento == null && funcion == null) {
				var declaraciones = algoritmo.tiene.declaracion
				declaraciones.addAll(algoritmo.global)
				var complejos = algoritmo.tipocomplejo
				completeCampoRegistro_Nombre_campoAux(context, acceptor, declaraciones, complejos, valorRegistro.nombre_registro)
			}
			else {
				if(procedimiento != null) {
					var declaraciones = procedimiento.declaracion
					declaraciones.addAll(algoritmo.global)
					var complejos = algoritmo.tipocomplejo
					completeCampoRegistro_Nombre_campoAux(context, acceptor, declaraciones, complejos, valorRegistro.nombre_registro)
				}
				else {
					var declaraciones = funcion.declaracion
					declaraciones.addAll(algoritmo.global)
					var complejos = algoritmo.tipocomplejo
					completeCampoRegistro_Nombre_campoAux(context, acceptor, declaraciones, complejos, valorRegistro.nombre_registro)
				}
			}
			
		}
		else if(context.getRootModel instanceof Modulo) {
			var modulo = context.getRootModel as Modulo
			var valorRegistro = context.getCurrentModel as ValorRegistro
			var procedimiento = EcoreUtil2.getContainerOfType(valorRegistro, Procedimiento)
			var funcion = EcoreUtil2.getContainerOfType(valorRegistro, Funcion)
			
			if(procedimiento != null) {
				var declaraciones = procedimiento.declaracion
				declaraciones.addAll(modulo.implementacion.global)
				var complejos = modulo.implementacion.tipocomplejo
				completeCampoRegistro_Nombre_campoAux(context, acceptor, declaraciones, complejos, valorRegistro.nombre_registro)
			}
			else {
				var declaraciones = funcion.declaracion
				declaraciones.addAll(modulo.implementacion.global)
				var complejos = modulo.implementacion.tipocomplejo
				completeCampoRegistro_Nombre_campoAux(context, acceptor, declaraciones, complejos, valorRegistro.nombre_registro)
			}
		}
	}
	
	def void completeCampoRegistro_Nombre_campoAux(ContentAssistContext context, ICompletionProposalAcceptor acceptor, List<Declaracion> declaraciones, List<TipoComplejo> complejos, String nombreVariable) {
		var tipo = ""
		for(Declaracion dec: declaraciones) {
			if(dec instanceof DeclaracionPropia) {
				var decPropia = dec as DeclaracionPropia
				for(Variable v: decPropia.variable) {
					if(v.nombre.equals(nombreVariable)) {
						tipo = decPropia.tipo
					}
				}
			}
			else {
				var decVariable = dec as DeclaracionVariable
				for(Variable v: decVariable.variable) {
					if(v.nombre.equals(nombreVariable)) {
						tipo = decVariable.tipo.literal
					}
				}
			}
		}
		
		for(TipoComplejo complejo: complejos) {
			if(complejo instanceof Registro) {
				var registro = complejo as Registro
				for(Declaracion dec: registro.variable) {
					if(dec instanceof DeclaracionPropia) {
						var decPropia = dec as DeclaracionPropia
						for(Variable v: decPropia.variable) {
							var completionProposal = createCompletionProposal(v.nombre, context)
							acceptor.accept(completionProposal)
						}
					}
					else {
						var decVariable = dec as DeclaracionVariable
						for(Variable v: decVariable.variable) {
							var completionProposal = createCompletionProposal(v.nombre, context)
							acceptor.accept(completionProposal)
						}
					}
				}
			}
		}
		
	}
	
}
