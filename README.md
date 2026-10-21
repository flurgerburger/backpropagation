# Neural Network Backpropagation Implementations

Implementations of feedforward neural networks trained with backpropagation in C# (.NET 10).

This repository contains three variants comparing training objectives and regularization techniques on classification problems:

1. **Standard Backpropagation (`BackPropBase.cs`)**:
   - Objective: Mean Squared Error (MSE).
   - Standard gradient descent with momentum.
2. **Cross-Entropy Backpropagation (`BackPropCrossEntropy.cs`)**:
   - Objective: Cross-Entropy loss with Softmax output activation.
   - Ideal for multi-class classification tasks.
3. **Weight Decay Backpropagation (`BackPropWeightDecay.cs`)**:
   - Objective: MSE with L2 Weight Regularization (Weight Decay).
   - Prevents overfitting by penalizing large weight values.

---

## Project Structure

```text
├── BackPropBase.cs                   # Standard MSE backpropagation
├── BackPropCrossEntropy.cs           # Cross-entropy error backpropagation
├── BackPropWeightDecay.cs            # L2 weight decay regularized backpropagation
├── BackPropProgram for CS345 IS 1.cs # Original template / reference file
├── BackPropagation.csproj            # .NET Project file
├── build-all.bat                     # Windows batch script to build all executables
├── build-all.ps1                     # PowerShell script to build all executables
└── README.md                         # Project documentation
```

---

## Prerequisites

- [.NET 10 SDK](https://dotnet.microsoft.com/download) (or later)

---

## Building Executables

To build all 3 executables at once:

- **Option A (Batch script):** Double-click `build-all.bat` or run in terminal:
  ```cmd
  build-all.bat
  ```
- **Option B (PowerShell):** Run:
  ```powershell
  .\build-all.ps1
  ```

Executables will be placed into:
- `executables/standalone/`: Fully self-contained `.exe` files (can run on any 64-bit Windows PC without .NET runtime installed).
- `executables/framework-dependent/`: Lightweight `.exe` files for systems with .NET 10 installed.

---

## Running from VS Code

- Press `Ctrl+Shift+D` to open the **Run & Debug** panel.
- Select the desired model profile and press `F5`.
