
# Explicación Técnica del Código del Token ERC20 Personalizado

## Introducción

Este documento explica paso a paso el código del contrato inteligente del token ERC20 personalizado, enfatizando cómo se implementaron todas las condiciones del proyecto a nivel de código.

---

## 1. Licencia y Versión de Solidity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;
```

- Se establece la licencia MIT.
- Se utiliza Solidity versión 0.8.27 que incluye mejoras y manejo seguro de números.

---

## 2. Importación de Contratos OpenZeppelin

```solidity
import {ERC20} from "@openzeppelin/contracts@5.3.0/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts@5.3.0/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Permit} from "@openzeppelin/contracts@5.3.0/token/ERC20/extensions/ERC20Permit.sol";
import {Ownable} from "@openzeppelin/contracts@5.3.0/access/Ownable.sol";
```

- `ERC20`: Implementa el estándar básico de tokens fungibles.
- `ERC20Burnable`: Permite que los usuarios quemen tokens.
- `ERC20Permit`: Soporta firmas off-chain para aprobaciones.
- `Ownable`: Controla acceso, define un dueño con privilegios.

---

## 3. Definición del Error Personalizado

```solidity
error MaxSupplyAlcanzado();
```

- Define un error para revertir la transacción si se supera el límite de tokens.

---

## 4. Declaración del Contrato y Herencia

```solidity
contract Coin is ERC20, ERC20Burnable, Ownable, ERC20Permit {
```

- Hereda las funcionalidades para token, quemar, permisos y dueño.

---

## 5. Variable Pública `maxSupply`

```solidity
uint256 public maxSupply;
```

- Almacena el límite máximo total de tokens.

---

## 6. Constructor

```solidity
constructor(address recipient, address initialOwner) ERC20("Coin", "MTK") Ownable(initialOwner) ERC20Permit("Coin") {
    maxSupply = 10_000_000 * 10 ** decimals();
    _mint(recipient, 1_000_000 * 10 ** decimals());
}
```

- Inicializa nombre, símbolo y dueño.
- Establece `maxSupply` en 10 millones tokens.
- Mintea 1 millón tokens inicialmente para `recipient`.

---

## 7. Función `mint` Personalizada

```solidity
function mint(address to, uint256 amount) public onlyOwner {
    if (totalSupply() + amount > maxSupply) {
        revert MaxSupplyAlcanzado();
    }
    _mint(to, amount);
}
```

- Solo el dueño puede mintear.
- Verifica que no se exceda `maxSupply`.
- Rechaza transacciones que superen el límite.

---

## Resumen

- Uso de OpenZeppelin para seguridad y estándares.
- Control estricto del suministro con límite `maxSupply`.
- Función de mint protegida con acceso restringido y validación.
- Suministro inicial definido en despliegue.

---
