
[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 10
  ny = 20
  xmax = 1
  ymax = 2
[]

[Variables]
  [temperature]
  []
[]

[Kernels]
  [heat_conduction]
    type = ADHeatConduction
    variable = temperature
  []
[]

[DiracKernels]
  [./pt0]
    type = ConstantPointSource
    variable = temperature
    value = 1.0
    point = '0.2 0.2'
  [../]
  [./pt1]
    type = ConstantPointSource
    variable = temperature
    value = -0.5
    point = '0.2 0.8'
  [../]
  [./pt2]
    type = ConstantPointSource
    variable = temperature
    value = -2
    point = '0.8 0.2'
  [../]
[]


[BCs]
  [left]
    type = DirichletBC
    variable = temperature
    boundary = left
    value = 0
  []
  [right]
    type = DirichletBC
    variable = temperature
    boundary = right
    value = 0
  []
  [bottom]
    type = DirichletBC
    variable = temperature
    boundary = bottom
    value = 0
  []
  [top]
    type = DirichletBC
    variable = temperature
    boundary = top
    value = 0
  []
[]

[Materials]
  [steel]
    type = ADGenericConstantMaterial
    prop_names = thermal_conductivity
    prop_values = 5
  []
[]

[Problem]#do we need this
  type = FEProblem
[]

[Executioner]
  type = Steady
  solve_type = PJFNK
  nl_abs_tol = 1e-6
  nl_rel_tol = 1e-8
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
[]

[VectorPostprocessors]
  [measure_pts]
    type = PointValueSampler
    variable = temperature
    points = '0.3 0.3 0
              0.4 1.0 0
              0.8 0.5 0
              0.8 0.6 0'
    sort_by = id
  []
[]


[Controls]
  [optimizationSamplerReceiver]
    type = ControlsReceiver
  []
[]


[Outputs]
  console = true
  exodus = true
[]
