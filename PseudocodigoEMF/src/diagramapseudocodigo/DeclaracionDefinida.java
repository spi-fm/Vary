/**
 */
package diagramapseudocodigo;

import org.eclipse.emf.common.util.EList;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Declaracion Definida</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link diagramapseudocodigo.DeclaracionDefinida#getVariables <em>Variables</em>}</li>
 * </ul>
 *
 * @see diagramapseudocodigo.DiagramapseudocodigoPackage#getDeclaracionDefinida()
 * @model
 * @generated
 */
public interface DeclaracionDefinida extends Declaracion {
	/**
	 * Returns the value of the '<em><b>Variables</b></em>' containment reference list.
	 * The list contents are of type {@link diagramapseudocodigo.Variable}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Variables</em>' containment reference list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Variables</em>' containment reference list.
	 * @see diagramapseudocodigo.DiagramapseudocodigoPackage#getDeclaracionDefinida_Variables()
	 * @model containment="true"
	 * @generated
	 */
	EList<Variable> getVariables();

} // DeclaracionDefinida
