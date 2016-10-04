/**
 */
package diagramapseudocodigo.impl;

import diagramapseudocodigo.DiagramapseudocodigoPackage;
import diagramapseudocodigo.Operacion;
import diagramapseudocodigo.OperacionCompleta;

import org.eclipse.emf.common.notify.Notification;
import org.eclipse.emf.common.notify.NotificationChain;

import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.InternalEObject;

import org.eclipse.emf.ecore.impl.ENotificationImpl;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Operacion Completa</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * </p>
 * <ul>
 *   <li>{@link diagramapseudocodigo.impl.OperacionCompletaImpl#getValor_operacion <em>Valor operacion</em>}</li>
 * </ul>
 *
 * @generated
 */
public class OperacionCompletaImpl extends OperacionImpl implements OperacionCompleta {
	/**
	 * The cached value of the '{@link #getValor_operacion() <em>Valor operacion</em>}' containment reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getValor_operacion()
	 * @generated
	 * @ordered
	 */
	protected Operacion valor_operacion;

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public OperacionCompletaImpl() {
		super();
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	protected EClass eStaticClass() {
		return DiagramapseudocodigoPackage.Literals.OPERACION_COMPLETA;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public Operacion getValor_operacion() {
		return valor_operacion;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public NotificationChain basicSetValor_operacion(Operacion newValor_operacion, NotificationChain msgs) {
		Operacion oldValor_operacion = valor_operacion;
		valor_operacion = newValor_operacion;
		if (eNotificationRequired()) {
			ENotificationImpl notification = new ENotificationImpl(this, Notification.SET, DiagramapseudocodigoPackage.OPERACION_COMPLETA__VALOR_OPERACION, oldValor_operacion, newValor_operacion);
			if (msgs == null) msgs = notification; else msgs.add(notification);
		}
		return msgs;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void setValor_operacion(Operacion newValor_operacion) {
		if (newValor_operacion != valor_operacion) {
			NotificationChain msgs = null;
			if (valor_operacion != null)
				msgs = ((InternalEObject)valor_operacion).eInverseRemove(this, EOPPOSITE_FEATURE_BASE - DiagramapseudocodigoPackage.OPERACION_COMPLETA__VALOR_OPERACION, null, msgs);
			if (newValor_operacion != null)
				msgs = ((InternalEObject)newValor_operacion).eInverseAdd(this, EOPPOSITE_FEATURE_BASE - DiagramapseudocodigoPackage.OPERACION_COMPLETA__VALOR_OPERACION, null, msgs);
			msgs = basicSetValor_operacion(newValor_operacion, msgs);
			if (msgs != null) msgs.dispatch();
		}
		else if (eNotificationRequired())
			eNotify(new ENotificationImpl(this, Notification.SET, DiagramapseudocodigoPackage.OPERACION_COMPLETA__VALOR_OPERACION, newValor_operacion, newValor_operacion));
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public NotificationChain eInverseRemove(InternalEObject otherEnd, int featureID, NotificationChain msgs) {
		switch (featureID) {
			case DiagramapseudocodigoPackage.OPERACION_COMPLETA__VALOR_OPERACION:
				return basicSetValor_operacion(null, msgs);
		}
		return super.eInverseRemove(otherEnd, featureID, msgs);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public Object eGet(int featureID, boolean resolve, boolean coreType) {
		switch (featureID) {
			case DiagramapseudocodigoPackage.OPERACION_COMPLETA__VALOR_OPERACION:
				return getValor_operacion();
		}
		return super.eGet(featureID, resolve, coreType);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public void eSet(int featureID, Object newValue) {
		switch (featureID) {
			case DiagramapseudocodigoPackage.OPERACION_COMPLETA__VALOR_OPERACION:
				setValor_operacion((Operacion)newValue);
				return;
		}
		super.eSet(featureID, newValue);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public void eUnset(int featureID) {
		switch (featureID) {
			case DiagramapseudocodigoPackage.OPERACION_COMPLETA__VALOR_OPERACION:
				setValor_operacion((Operacion)null);
				return;
		}
		super.eUnset(featureID);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public boolean eIsSet(int featureID) {
		switch (featureID) {
			case DiagramapseudocodigoPackage.OPERACION_COMPLETA__VALOR_OPERACION:
				return valor_operacion != null;
		}
		return super.eIsSet(featureID);
	}

} //OperacionCompletaImpl
