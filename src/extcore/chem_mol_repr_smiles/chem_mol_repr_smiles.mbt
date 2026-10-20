///===
/// extcore/chem_mol_repr_smiles

pub(all) struct ChemmolreprsmilesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_smiles_make_point(x : Double, y : Double) -> ChemmolreprsmilesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_smiles_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprsmilesPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolreprsmilesPoint::x(self : ChemmolreprsmilesPoint) -> Double { self.x }

pub fn ChemmolreprsmilesPoint::y(self : ChemmolreprsmilesPoint) -> Double { self.y }

pub fn ChemmolreprsmilesPoint::z(self : ChemmolreprsmilesPoint) -> Double { self.z }

pub fn ChemmolreprsmilesPoint::label(self : ChemmolreprsmilesPoint) -> Int { self.label }

pub fn ChemmolreprsmilesPoint::dist(self : ChemmolreprsmilesPoint, other : ChemmolreprsmilesPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolreprsmilesPoint::add(self : ChemmolreprsmilesPoint, other : ChemmolreprsmilesPoint) -> ChemmolreprsmilesPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolreprsmilesPoint::sub(self : ChemmolreprsmilesPoint, other : ChemmolreprsmilesPoint) -> ChemmolreprsmilesPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolreprsmilesPoint::scale(self : ChemmolreprsmilesPoint, s : Double) -> ChemmolreprsmilesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolreprsmilesPoint::dot(self : ChemmolreprsmilesPoint, other : ChemmolreprsmilesPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolreprsmilesPoint::cross(self : ChemmolreprsmilesPoint, other : ChemmolreprsmilesPoint) -> ChemmolreprsmilesPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolreprsmilesPoint::norm(self : ChemmolreprsmilesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolreprsmilesPoint::normalize(self : ChemmolreprsmilesPoint) -> ChemmolreprsmilesPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprsmilesPoint::negate(self : ChemmolreprsmilesPoint) -> ChemmolreprsmilesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolreprsmilesPoint::mid(self : ChemmolreprsmilesPoint, other : ChemmolreprsmilesPoint) -> ChemmolreprsmilesPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolreprsmilesPoint::lerp(self : ChemmolreprsmilesPoint, other : ChemmolreprsmilesPoint, t : Double) -> ChemmolreprsmilesPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolreprsmilesPoint::to_string(self : ChemmolreprsmilesPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_smiles_make_series(vals : Array[Double], name : String) -> ChemmolreprsmilesSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolreprsmilesSeries::len(self : ChemmolreprsmilesSeries) -> Int { self.vals.length() }

pub fn ChemmolreprsmilesSeries::sum(self : ChemmolreprsmilesSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolreprsmilesSeries::mean(self : ChemmolreprsmilesSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolreprsmilesSeries::min(self : ChemmolreprsmilesSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolreprsmilesSeries::max(self : ChemmolreprsmilesSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolreprsmilesSeries::range(self : ChemmolreprsmilesSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolreprsmilesSeries::variance(self : ChemmolreprsmilesSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolreprsmilesSeries::std(self : ChemmolreprsmilesSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolreprsmilesSeries::median(self : ChemmolreprsmilesSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolreprsmilesSeries::scale(self : ChemmolreprsmilesSeries, f : Double) -> ChemmolreprsmilesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolreprsmilesSeries::add(self : ChemmolreprsmilesSeries, other : ChemmolreprsmilesSeries) -> ChemmolreprsmilesSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolreprsmilesSeries::sub(self : ChemmolreprsmilesSeries, other : ChemmolreprsmilesSeries) -> ChemmolreprsmilesSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolreprsmilesSeries::normalize(self : ChemmolreprsmilesSeries) -> ChemmolreprsmilesSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolreprsmilesSeries::cumsum(self : ChemmolreprsmilesSeries) -> ChemmolreprsmilesSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolreprsmilesSeries::to_string(self : ChemmolreprsmilesSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprsmilesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_smiles_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprsmilesMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn chem_mol_repr_smiles_matrix_identity(n : Int) -> ChemmolreprsmilesMatrix {
  let m = chem_mol_repr_smiles_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolreprsmilesMatrix::get(self : ChemmolreprsmilesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolreprsmilesMatrix::transpose(self : ChemmolreprsmilesMatrix) -> ChemmolreprsmilesMatrix {
  let result = chem_mol_repr_smiles_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolreprsmilesMatrix::add(self : ChemmolreprsmilesMatrix, other : ChemmolreprsmilesMatrix) -> ChemmolreprsmilesMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_repr_smiles_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolreprsmilesMatrix::scale(self : ChemmolreprsmilesMatrix, s : Double) -> ChemmolreprsmilesMatrix {
  let result = chem_mol_repr_smiles_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolreprsmilesMatrix::multiply(self : ChemmolreprsmilesMatrix, other : ChemmolreprsmilesMatrix) -> ChemmolreprsmilesMatrix {
  if self.cols != other.rows { return chem_mol_repr_smiles_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_repr_smiles_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ChemmolreprsmilesMatrix::trace(self : ChemmolreprsmilesMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolreprsmilesMatrix::det(self : ChemmolreprsmilesMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolreprsmilesMatrix::norm(self : ChemmolreprsmilesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolreprsmilesMatrix::to_string(self : ChemmolreprsmilesMatrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ChemmolreprsmilesVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_smiles_make_vector(comps : Array[Double]) -> ChemmolreprsmilesVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_smiles_vector_zero(dim : Int) -> ChemmolreprsmilesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolreprsmilesVector::add(self : ChemmolreprsmilesVector, other : ChemmolreprsmilesVector) -> ChemmolreprsmilesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprsmilesVector::sub(self : ChemmolreprsmilesVector, other : ChemmolreprsmilesVector) -> ChemmolreprsmilesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprsmilesVector::scale(self : ChemmolreprsmilesVector, s : Double) -> ChemmolreprsmilesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolreprsmilesVector::dot(self : ChemmolreprsmilesVector, other : ChemmolreprsmilesVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolreprsmilesVector::norm(self : ChemmolreprsmilesVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolreprsmilesVector::normalize(self : ChemmolreprsmilesVector) -> ChemmolreprsmilesVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprsmilesVector::dist(self : ChemmolreprsmilesVector, other : ChemmolreprsmilesVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolreprsmilesVector::to_string(self : ChemmolreprsmilesVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprsmilesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_frame_make(size : Int) -> ChemmolreprsmilesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsmilesFrame::len(self : ChemmolreprsmilesFrame) -> Int { self.size }

pub fn ChemmolreprsmilesFrame::get(self : ChemmolreprsmilesFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsmilesFrame::set(self : ChemmolreprsmilesFrame, i : Int, v : Double) -> ChemmolreprsmilesFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesFrame::sum(self : ChemmolreprsmilesFrame) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsmilesFrame::mean(self : ChemmolreprsmilesFrame) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsmilesFrame::scale(self : ChemmolreprsmilesFrame, f : Double) -> ChemmolreprsmilesFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesFrame::add(self : ChemmolreprsmilesFrame, other : ChemmolreprsmilesFrame) -> ChemmolreprsmilesFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsmilesFrame::copy(self : ChemmolreprsmilesFrame) -> ChemmolreprsmilesFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesFrame::fill(self : ChemmolreprsmilesFrame, v : Double) -> ChemmolreprsmilesFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesFrame::min(self : ChemmolreprsmilesFrame) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsmilesFrame::max(self : ChemmolreprsmilesFrame) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsmilesFrame::to_string(self : ChemmolreprsmilesFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_table_make(size : Int) -> ChemmolreprsmilesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsmilesTable::len(self : ChemmolreprsmilesTable) -> Int { self.size }

pub fn ChemmolreprsmilesTable::get(self : ChemmolreprsmilesTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsmilesTable::set(self : ChemmolreprsmilesTable, i : Int, v : Double) -> ChemmolreprsmilesTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesTable::sum(self : ChemmolreprsmilesTable) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsmilesTable::mean(self : ChemmolreprsmilesTable) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsmilesTable::scale(self : ChemmolreprsmilesTable, f : Double) -> ChemmolreprsmilesTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesTable::add(self : ChemmolreprsmilesTable, other : ChemmolreprsmilesTable) -> ChemmolreprsmilesTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsmilesTable::copy(self : ChemmolreprsmilesTable) -> ChemmolreprsmilesTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesTable::fill(self : ChemmolreprsmilesTable, v : Double) -> ChemmolreprsmilesTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesTable::min(self : ChemmolreprsmilesTable) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsmilesTable::max(self : ChemmolreprsmilesTable) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsmilesTable::to_string(self : ChemmolreprsmilesTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_graphn_make(size : Int) -> ChemmolreprsmilesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsmilesGraphN::len(self : ChemmolreprsmilesGraphN) -> Int { self.size }

pub fn ChemmolreprsmilesGraphN::get(self : ChemmolreprsmilesGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsmilesGraphN::set(self : ChemmolreprsmilesGraphN, i : Int, v : Double) -> ChemmolreprsmilesGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesGraphN::sum(self : ChemmolreprsmilesGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsmilesGraphN::mean(self : ChemmolreprsmilesGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsmilesGraphN::scale(self : ChemmolreprsmilesGraphN, f : Double) -> ChemmolreprsmilesGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesGraphN::add(self : ChemmolreprsmilesGraphN, other : ChemmolreprsmilesGraphN) -> ChemmolreprsmilesGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsmilesGraphN::copy(self : ChemmolreprsmilesGraphN) -> ChemmolreprsmilesGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesGraphN::fill(self : ChemmolreprsmilesGraphN, v : Double) -> ChemmolreprsmilesGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesGraphN::min(self : ChemmolreprsmilesGraphN) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsmilesGraphN::max(self : ChemmolreprsmilesGraphN) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsmilesGraphN::to_string(self : ChemmolreprsmilesGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_node_make(size : Int) -> ChemmolreprsmilesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsmilesNode::len(self : ChemmolreprsmilesNode) -> Int { self.size }

pub fn ChemmolreprsmilesNode::get(self : ChemmolreprsmilesNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsmilesNode::set(self : ChemmolreprsmilesNode, i : Int, v : Double) -> ChemmolreprsmilesNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesNode::sum(self : ChemmolreprsmilesNode) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsmilesNode::mean(self : ChemmolreprsmilesNode) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsmilesNode::scale(self : ChemmolreprsmilesNode, f : Double) -> ChemmolreprsmilesNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesNode::add(self : ChemmolreprsmilesNode, other : ChemmolreprsmilesNode) -> ChemmolreprsmilesNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsmilesNode::copy(self : ChemmolreprsmilesNode) -> ChemmolreprsmilesNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesNode::fill(self : ChemmolreprsmilesNode, v : Double) -> ChemmolreprsmilesNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesNode::min(self : ChemmolreprsmilesNode) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsmilesNode::max(self : ChemmolreprsmilesNode) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsmilesNode::to_string(self : ChemmolreprsmilesNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_edge_make(size : Int) -> ChemmolreprsmilesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsmilesEdge::len(self : ChemmolreprsmilesEdge) -> Int { self.size }

pub fn ChemmolreprsmilesEdge::get(self : ChemmolreprsmilesEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsmilesEdge::set(self : ChemmolreprsmilesEdge, i : Int, v : Double) -> ChemmolreprsmilesEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesEdge::sum(self : ChemmolreprsmilesEdge) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsmilesEdge::mean(self : ChemmolreprsmilesEdge) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsmilesEdge::scale(self : ChemmolreprsmilesEdge, f : Double) -> ChemmolreprsmilesEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesEdge::add(self : ChemmolreprsmilesEdge, other : ChemmolreprsmilesEdge) -> ChemmolreprsmilesEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsmilesEdge::copy(self : ChemmolreprsmilesEdge) -> ChemmolreprsmilesEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesEdge::fill(self : ChemmolreprsmilesEdge, v : Double) -> ChemmolreprsmilesEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesEdge::min(self : ChemmolreprsmilesEdge) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsmilesEdge::max(self : ChemmolreprsmilesEdge) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsmilesEdge::to_string(self : ChemmolreprsmilesEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_path_make(size : Int) -> ChemmolreprsmilesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsmilesPath::len(self : ChemmolreprsmilesPath) -> Int { self.size }

pub fn ChemmolreprsmilesPath::get(self : ChemmolreprsmilesPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsmilesPath::set(self : ChemmolreprsmilesPath, i : Int, v : Double) -> ChemmolreprsmilesPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesPath::sum(self : ChemmolreprsmilesPath) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsmilesPath::mean(self : ChemmolreprsmilesPath) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsmilesPath::scale(self : ChemmolreprsmilesPath, f : Double) -> ChemmolreprsmilesPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesPath::add(self : ChemmolreprsmilesPath, other : ChemmolreprsmilesPath) -> ChemmolreprsmilesPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsmilesPath::copy(self : ChemmolreprsmilesPath) -> ChemmolreprsmilesPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesPath::fill(self : ChemmolreprsmilesPath, v : Double) -> ChemmolreprsmilesPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesPath::min(self : ChemmolreprsmilesPath) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsmilesPath::max(self : ChemmolreprsmilesPath) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsmilesPath::to_string(self : ChemmolreprsmilesPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_cluster_make(size : Int) -> ChemmolreprsmilesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsmilesCluster::len(self : ChemmolreprsmilesCluster) -> Int { self.size }

pub fn ChemmolreprsmilesCluster::get(self : ChemmolreprsmilesCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsmilesCluster::set(self : ChemmolreprsmilesCluster, i : Int, v : Double) -> ChemmolreprsmilesCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesCluster::sum(self : ChemmolreprsmilesCluster) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsmilesCluster::mean(self : ChemmolreprsmilesCluster) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsmilesCluster::scale(self : ChemmolreprsmilesCluster, f : Double) -> ChemmolreprsmilesCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesCluster::add(self : ChemmolreprsmilesCluster, other : ChemmolreprsmilesCluster) -> ChemmolreprsmilesCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsmilesCluster::copy(self : ChemmolreprsmilesCluster) -> ChemmolreprsmilesCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesCluster::fill(self : ChemmolreprsmilesCluster, v : Double) -> ChemmolreprsmilesCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesCluster::min(self : ChemmolreprsmilesCluster) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsmilesCluster::max(self : ChemmolreprsmilesCluster) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsmilesCluster::to_string(self : ChemmolreprsmilesCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_model_make(size : Int) -> ChemmolreprsmilesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsmilesModel::len(self : ChemmolreprsmilesModel) -> Int { self.size }

pub fn ChemmolreprsmilesModel::get(self : ChemmolreprsmilesModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsmilesModel::set(self : ChemmolreprsmilesModel, i : Int, v : Double) -> ChemmolreprsmilesModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesModel::sum(self : ChemmolreprsmilesModel) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsmilesModel::mean(self : ChemmolreprsmilesModel) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsmilesModel::scale(self : ChemmolreprsmilesModel, f : Double) -> ChemmolreprsmilesModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesModel::add(self : ChemmolreprsmilesModel, other : ChemmolreprsmilesModel) -> ChemmolreprsmilesModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsmilesModel::copy(self : ChemmolreprsmilesModel) -> ChemmolreprsmilesModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesModel::fill(self : ChemmolreprsmilesModel, v : Double) -> ChemmolreprsmilesModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesModel::min(self : ChemmolreprsmilesModel) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsmilesModel::max(self : ChemmolreprsmilesModel) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsmilesModel::to_string(self : ChemmolreprsmilesModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_layer_make(size : Int) -> ChemmolreprsmilesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsmilesLayer::len(self : ChemmolreprsmilesLayer) -> Int { self.size }

pub fn ChemmolreprsmilesLayer::get(self : ChemmolreprsmilesLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsmilesLayer::set(self : ChemmolreprsmilesLayer, i : Int, v : Double) -> ChemmolreprsmilesLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesLayer::sum(self : ChemmolreprsmilesLayer) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsmilesLayer::mean(self : ChemmolreprsmilesLayer) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsmilesLayer::scale(self : ChemmolreprsmilesLayer, f : Double) -> ChemmolreprsmilesLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesLayer::add(self : ChemmolreprsmilesLayer, other : ChemmolreprsmilesLayer) -> ChemmolreprsmilesLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsmilesLayer::copy(self : ChemmolreprsmilesLayer) -> ChemmolreprsmilesLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesLayer::fill(self : ChemmolreprsmilesLayer, v : Double) -> ChemmolreprsmilesLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesLayer::min(self : ChemmolreprsmilesLayer) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsmilesLayer::max(self : ChemmolreprsmilesLayer) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsmilesLayer::to_string(self : ChemmolreprsmilesLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_buffer_make(size : Int) -> ChemmolreprsmilesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsmilesBuffer::len(self : ChemmolreprsmilesBuffer) -> Int { self.size }

pub fn ChemmolreprsmilesBuffer::get(self : ChemmolreprsmilesBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsmilesBuffer::set(self : ChemmolreprsmilesBuffer, i : Int, v : Double) -> ChemmolreprsmilesBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesBuffer::sum(self : ChemmolreprsmilesBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsmilesBuffer::mean(self : ChemmolreprsmilesBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsmilesBuffer::scale(self : ChemmolreprsmilesBuffer, f : Double) -> ChemmolreprsmilesBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesBuffer::add(self : ChemmolreprsmilesBuffer, other : ChemmolreprsmilesBuffer) -> ChemmolreprsmilesBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsmilesBuffer::copy(self : ChemmolreprsmilesBuffer) -> ChemmolreprsmilesBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesBuffer::fill(self : ChemmolreprsmilesBuffer, v : Double) -> ChemmolreprsmilesBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesBuffer::min(self : ChemmolreprsmilesBuffer) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsmilesBuffer::max(self : ChemmolreprsmilesBuffer) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsmilesBuffer::to_string(self : ChemmolreprsmilesBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_cursor_make(size : Int) -> ChemmolreprsmilesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsmilesCursor::len(self : ChemmolreprsmilesCursor) -> Int { self.size }

pub fn ChemmolreprsmilesCursor::get(self : ChemmolreprsmilesCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsmilesCursor::set(self : ChemmolreprsmilesCursor, i : Int, v : Double) -> ChemmolreprsmilesCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesCursor::sum(self : ChemmolreprsmilesCursor) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsmilesCursor::mean(self : ChemmolreprsmilesCursor) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsmilesCursor::scale(self : ChemmolreprsmilesCursor, f : Double) -> ChemmolreprsmilesCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesCursor::add(self : ChemmolreprsmilesCursor, other : ChemmolreprsmilesCursor) -> ChemmolreprsmilesCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsmilesCursor::copy(self : ChemmolreprsmilesCursor) -> ChemmolreprsmilesCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesCursor::fill(self : ChemmolreprsmilesCursor, v : Double) -> ChemmolreprsmilesCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesCursor::min(self : ChemmolreprsmilesCursor) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsmilesCursor::max(self : ChemmolreprsmilesCursor) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsmilesCursor::to_string(self : ChemmolreprsmilesCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_view_make(size : Int) -> ChemmolreprsmilesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsmilesView::len(self : ChemmolreprsmilesView) -> Int { self.size }

pub fn ChemmolreprsmilesView::get(self : ChemmolreprsmilesView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsmilesView::set(self : ChemmolreprsmilesView, i : Int, v : Double) -> ChemmolreprsmilesView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesView::sum(self : ChemmolreprsmilesView) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsmilesView::mean(self : ChemmolreprsmilesView) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsmilesView::scale(self : ChemmolreprsmilesView, f : Double) -> ChemmolreprsmilesView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesView::add(self : ChemmolreprsmilesView, other : ChemmolreprsmilesView) -> ChemmolreprsmilesView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsmilesView::copy(self : ChemmolreprsmilesView) -> ChemmolreprsmilesView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesView::fill(self : ChemmolreprsmilesView, v : Double) -> ChemmolreprsmilesView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesView::min(self : ChemmolreprsmilesView) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsmilesView::max(self : ChemmolreprsmilesView) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsmilesView::to_string(self : ChemmolreprsmilesView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_range_make(size : Int) -> ChemmolreprsmilesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsmilesRange::len(self : ChemmolreprsmilesRange) -> Int { self.size }

pub fn ChemmolreprsmilesRange::get(self : ChemmolreprsmilesRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsmilesRange::set(self : ChemmolreprsmilesRange, i : Int, v : Double) -> ChemmolreprsmilesRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesRange::sum(self : ChemmolreprsmilesRange) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsmilesRange::mean(self : ChemmolreprsmilesRange) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsmilesRange::scale(self : ChemmolreprsmilesRange, f : Double) -> ChemmolreprsmilesRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesRange::add(self : ChemmolreprsmilesRange, other : ChemmolreprsmilesRange) -> ChemmolreprsmilesRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsmilesRange::copy(self : ChemmolreprsmilesRange) -> ChemmolreprsmilesRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesRange::fill(self : ChemmolreprsmilesRange, v : Double) -> ChemmolreprsmilesRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesRange::min(self : ChemmolreprsmilesRange) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsmilesRange::max(self : ChemmolreprsmilesRange) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsmilesRange::to_string(self : ChemmolreprsmilesRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsmilesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_smiles_slice_make(size : Int) -> ChemmolreprsmilesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprsmilesSlice::len(self : ChemmolreprsmilesSlice) -> Int { self.size }

pub fn ChemmolreprsmilesSlice::get(self : ChemmolreprsmilesSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprsmilesSlice::set(self : ChemmolreprsmilesSlice, i : Int, v : Double) -> ChemmolreprsmilesSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesSlice::sum(self : ChemmolreprsmilesSlice) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprsmilesSlice::mean(self : ChemmolreprsmilesSlice) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprsmilesSlice::scale(self : ChemmolreprsmilesSlice, f : Double) -> ChemmolreprsmilesSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesSlice::add(self : ChemmolreprsmilesSlice, other : ChemmolreprsmilesSlice) -> ChemmolreprsmilesSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprsmilesSlice::copy(self : ChemmolreprsmilesSlice) -> ChemmolreprsmilesSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesSlice::fill(self : ChemmolreprsmilesSlice, v : Double) -> ChemmolreprsmilesSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprsmilesSlice::min(self : ChemmolreprsmilesSlice) -> Double { @_common.min(self.data) }

pub fn ChemmolreprsmilesSlice::max(self : ChemmolreprsmilesSlice) -> Double { @_common.max(self.data) }

pub fn ChemmolreprsmilesSlice::to_string(self : ChemmolreprsmilesSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

