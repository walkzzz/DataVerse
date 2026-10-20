///===
/// extcore/chem_mol_props_tpsa

pub(all) struct ChemmolpropstpsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_tpsa_make_point(x : Double, y : Double) -> ChemmolpropstpsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_tpsa_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropstpsaPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolpropstpsaPoint::x(self : ChemmolpropstpsaPoint) -> Double { self.x }

pub fn ChemmolpropstpsaPoint::y(self : ChemmolpropstpsaPoint) -> Double { self.y }

pub fn ChemmolpropstpsaPoint::z(self : ChemmolpropstpsaPoint) -> Double { self.z }

pub fn ChemmolpropstpsaPoint::label(self : ChemmolpropstpsaPoint) -> Int { self.label }

pub fn ChemmolpropstpsaPoint::dist(self : ChemmolpropstpsaPoint, other : ChemmolpropstpsaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolpropstpsaPoint::add(self : ChemmolpropstpsaPoint, other : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolpropstpsaPoint::sub(self : ChemmolpropstpsaPoint, other : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolpropstpsaPoint::scale(self : ChemmolpropstpsaPoint, s : Double) -> ChemmolpropstpsaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolpropstpsaPoint::dot(self : ChemmolpropstpsaPoint, other : ChemmolpropstpsaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolpropstpsaPoint::cross(self : ChemmolpropstpsaPoint, other : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolpropstpsaPoint::norm(self : ChemmolpropstpsaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolpropstpsaPoint::normalize(self : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropstpsaPoint::negate(self : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolpropstpsaPoint::mid(self : ChemmolpropstpsaPoint, other : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolpropstpsaPoint::lerp(self : ChemmolpropstpsaPoint, other : ChemmolpropstpsaPoint, t : Double) -> ChemmolpropstpsaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolpropstpsaPoint::to_string(self : ChemmolpropstpsaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_tpsa_make_series(vals : Array[Double], name : String) -> ChemmolpropstpsaSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolpropstpsaSeries::len(self : ChemmolpropstpsaSeries) -> Int { self.vals.length() }

pub fn ChemmolpropstpsaSeries::sum(self : ChemmolpropstpsaSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolpropstpsaSeries::mean(self : ChemmolpropstpsaSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolpropstpsaSeries::min(self : ChemmolpropstpsaSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolpropstpsaSeries::max(self : ChemmolpropstpsaSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolpropstpsaSeries::range(self : ChemmolpropstpsaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolpropstpsaSeries::variance(self : ChemmolpropstpsaSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolpropstpsaSeries::std(self : ChemmolpropstpsaSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolpropstpsaSeries::median(self : ChemmolpropstpsaSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolpropstpsaSeries::scale(self : ChemmolpropstpsaSeries, f : Double) -> ChemmolpropstpsaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolpropstpsaSeries::add(self : ChemmolpropstpsaSeries, other : ChemmolpropstpsaSeries) -> ChemmolpropstpsaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolpropstpsaSeries::sub(self : ChemmolpropstpsaSeries, other : ChemmolpropstpsaSeries) -> ChemmolpropstpsaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolpropstpsaSeries::normalize(self : ChemmolpropstpsaSeries) -> ChemmolpropstpsaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolpropstpsaSeries::cumsum(self : ChemmolpropstpsaSeries) -> ChemmolpropstpsaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolpropstpsaSeries::to_string(self : ChemmolpropstpsaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropstpsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_tpsa_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropstpsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_tpsa_matrix_identity(n : Int) -> ChemmolpropstpsaMatrix {
  let m = chem_mol_props_tpsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolpropstpsaMatrix::get(self : ChemmolpropstpsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolpropstpsaMatrix::transpose(self : ChemmolpropstpsaMatrix) -> ChemmolpropstpsaMatrix {
  let result = chem_mol_props_tpsa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolpropstpsaMatrix::add(self : ChemmolpropstpsaMatrix, other : ChemmolpropstpsaMatrix) -> ChemmolpropstpsaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_props_tpsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolpropstpsaMatrix::scale(self : ChemmolpropstpsaMatrix, s : Double) -> ChemmolpropstpsaMatrix {
  let result = chem_mol_props_tpsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolpropstpsaMatrix::multiply(self : ChemmolpropstpsaMatrix, other : ChemmolpropstpsaMatrix) -> ChemmolpropstpsaMatrix {
  if self.cols != other.rows { return chem_mol_props_tpsa_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_props_tpsa_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolpropstpsaMatrix::trace(self : ChemmolpropstpsaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolpropstpsaMatrix::det(self : ChemmolpropstpsaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolpropstpsaMatrix::norm(self : ChemmolpropstpsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolpropstpsaMatrix::to_string(self : ChemmolpropstpsaMatrix) -> String {
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

pub(all) struct ChemmolpropstpsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_tpsa_make_vector(comps : Array[Double]) -> ChemmolpropstpsaVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_tpsa_vector_zero(dim : Int) -> ChemmolpropstpsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolpropstpsaVector::add(self : ChemmolpropstpsaVector, other : ChemmolpropstpsaVector) -> ChemmolpropstpsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropstpsaVector::sub(self : ChemmolpropstpsaVector, other : ChemmolpropstpsaVector) -> ChemmolpropstpsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropstpsaVector::scale(self : ChemmolpropstpsaVector, s : Double) -> ChemmolpropstpsaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolpropstpsaVector::dot(self : ChemmolpropstpsaVector, other : ChemmolpropstpsaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolpropstpsaVector::norm(self : ChemmolpropstpsaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolpropstpsaVector::normalize(self : ChemmolpropstpsaVector) -> ChemmolpropstpsaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropstpsaVector::dist(self : ChemmolpropstpsaVector, other : ChemmolpropstpsaVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolpropstpsaVector::to_string(self : ChemmolpropstpsaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropstpsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_frame_make(size : Int) -> ChemmolpropstpsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropstpsaFrame::len(self : ChemmolpropstpsaFrame) -> Int { self.size }

pub fn ChemmolpropstpsaFrame::get(self : ChemmolpropstpsaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropstpsaFrame::set(self : ChemmolpropstpsaFrame, i : Int, v : Double) -> ChemmolpropstpsaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaFrame::sum(self : ChemmolpropstpsaFrame) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropstpsaFrame::mean(self : ChemmolpropstpsaFrame) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropstpsaFrame::scale(self : ChemmolpropstpsaFrame, f : Double) -> ChemmolpropstpsaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaFrame::add(self : ChemmolpropstpsaFrame, other : ChemmolpropstpsaFrame) -> ChemmolpropstpsaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropstpsaFrame::copy(self : ChemmolpropstpsaFrame) -> ChemmolpropstpsaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaFrame::fill(self : ChemmolpropstpsaFrame, v : Double) -> ChemmolpropstpsaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaFrame::min(self : ChemmolpropstpsaFrame) -> Double { @_common.min(self.data) }

pub fn ChemmolpropstpsaFrame::max(self : ChemmolpropstpsaFrame) -> Double { @_common.max(self.data) }

pub fn ChemmolpropstpsaFrame::to_string(self : ChemmolpropstpsaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_table_make(size : Int) -> ChemmolpropstpsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropstpsaTable::len(self : ChemmolpropstpsaTable) -> Int { self.size }

pub fn ChemmolpropstpsaTable::get(self : ChemmolpropstpsaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropstpsaTable::set(self : ChemmolpropstpsaTable, i : Int, v : Double) -> ChemmolpropstpsaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaTable::sum(self : ChemmolpropstpsaTable) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropstpsaTable::mean(self : ChemmolpropstpsaTable) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropstpsaTable::scale(self : ChemmolpropstpsaTable, f : Double) -> ChemmolpropstpsaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaTable::add(self : ChemmolpropstpsaTable, other : ChemmolpropstpsaTable) -> ChemmolpropstpsaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropstpsaTable::copy(self : ChemmolpropstpsaTable) -> ChemmolpropstpsaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaTable::fill(self : ChemmolpropstpsaTable, v : Double) -> ChemmolpropstpsaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaTable::min(self : ChemmolpropstpsaTable) -> Double { @_common.min(self.data) }

pub fn ChemmolpropstpsaTable::max(self : ChemmolpropstpsaTable) -> Double { @_common.max(self.data) }

pub fn ChemmolpropstpsaTable::to_string(self : ChemmolpropstpsaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_graphn_make(size : Int) -> ChemmolpropstpsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropstpsaGraphN::len(self : ChemmolpropstpsaGraphN) -> Int { self.size }

pub fn ChemmolpropstpsaGraphN::get(self : ChemmolpropstpsaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropstpsaGraphN::set(self : ChemmolpropstpsaGraphN, i : Int, v : Double) -> ChemmolpropstpsaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaGraphN::sum(self : ChemmolpropstpsaGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropstpsaGraphN::mean(self : ChemmolpropstpsaGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropstpsaGraphN::scale(self : ChemmolpropstpsaGraphN, f : Double) -> ChemmolpropstpsaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaGraphN::add(self : ChemmolpropstpsaGraphN, other : ChemmolpropstpsaGraphN) -> ChemmolpropstpsaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropstpsaGraphN::copy(self : ChemmolpropstpsaGraphN) -> ChemmolpropstpsaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaGraphN::fill(self : ChemmolpropstpsaGraphN, v : Double) -> ChemmolpropstpsaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaGraphN::min(self : ChemmolpropstpsaGraphN) -> Double { @_common.min(self.data) }

pub fn ChemmolpropstpsaGraphN::max(self : ChemmolpropstpsaGraphN) -> Double { @_common.max(self.data) }

pub fn ChemmolpropstpsaGraphN::to_string(self : ChemmolpropstpsaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_node_make(size : Int) -> ChemmolpropstpsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropstpsaNode::len(self : ChemmolpropstpsaNode) -> Int { self.size }

pub fn ChemmolpropstpsaNode::get(self : ChemmolpropstpsaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropstpsaNode::set(self : ChemmolpropstpsaNode, i : Int, v : Double) -> ChemmolpropstpsaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaNode::sum(self : ChemmolpropstpsaNode) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropstpsaNode::mean(self : ChemmolpropstpsaNode) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropstpsaNode::scale(self : ChemmolpropstpsaNode, f : Double) -> ChemmolpropstpsaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaNode::add(self : ChemmolpropstpsaNode, other : ChemmolpropstpsaNode) -> ChemmolpropstpsaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropstpsaNode::copy(self : ChemmolpropstpsaNode) -> ChemmolpropstpsaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaNode::fill(self : ChemmolpropstpsaNode, v : Double) -> ChemmolpropstpsaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaNode::min(self : ChemmolpropstpsaNode) -> Double { @_common.min(self.data) }

pub fn ChemmolpropstpsaNode::max(self : ChemmolpropstpsaNode) -> Double { @_common.max(self.data) }

pub fn ChemmolpropstpsaNode::to_string(self : ChemmolpropstpsaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_edge_make(size : Int) -> ChemmolpropstpsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropstpsaEdge::len(self : ChemmolpropstpsaEdge) -> Int { self.size }

pub fn ChemmolpropstpsaEdge::get(self : ChemmolpropstpsaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropstpsaEdge::set(self : ChemmolpropstpsaEdge, i : Int, v : Double) -> ChemmolpropstpsaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaEdge::sum(self : ChemmolpropstpsaEdge) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropstpsaEdge::mean(self : ChemmolpropstpsaEdge) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropstpsaEdge::scale(self : ChemmolpropstpsaEdge, f : Double) -> ChemmolpropstpsaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaEdge::add(self : ChemmolpropstpsaEdge, other : ChemmolpropstpsaEdge) -> ChemmolpropstpsaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropstpsaEdge::copy(self : ChemmolpropstpsaEdge) -> ChemmolpropstpsaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaEdge::fill(self : ChemmolpropstpsaEdge, v : Double) -> ChemmolpropstpsaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaEdge::min(self : ChemmolpropstpsaEdge) -> Double { @_common.min(self.data) }

pub fn ChemmolpropstpsaEdge::max(self : ChemmolpropstpsaEdge) -> Double { @_common.max(self.data) }

pub fn ChemmolpropstpsaEdge::to_string(self : ChemmolpropstpsaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_path_make(size : Int) -> ChemmolpropstpsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropstpsaPath::len(self : ChemmolpropstpsaPath) -> Int { self.size }

pub fn ChemmolpropstpsaPath::get(self : ChemmolpropstpsaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropstpsaPath::set(self : ChemmolpropstpsaPath, i : Int, v : Double) -> ChemmolpropstpsaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaPath::sum(self : ChemmolpropstpsaPath) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropstpsaPath::mean(self : ChemmolpropstpsaPath) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropstpsaPath::scale(self : ChemmolpropstpsaPath, f : Double) -> ChemmolpropstpsaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaPath::add(self : ChemmolpropstpsaPath, other : ChemmolpropstpsaPath) -> ChemmolpropstpsaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropstpsaPath::copy(self : ChemmolpropstpsaPath) -> ChemmolpropstpsaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaPath::fill(self : ChemmolpropstpsaPath, v : Double) -> ChemmolpropstpsaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaPath::min(self : ChemmolpropstpsaPath) -> Double { @_common.min(self.data) }

pub fn ChemmolpropstpsaPath::max(self : ChemmolpropstpsaPath) -> Double { @_common.max(self.data) }

pub fn ChemmolpropstpsaPath::to_string(self : ChemmolpropstpsaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_cluster_make(size : Int) -> ChemmolpropstpsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropstpsaCluster::len(self : ChemmolpropstpsaCluster) -> Int { self.size }

pub fn ChemmolpropstpsaCluster::get(self : ChemmolpropstpsaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropstpsaCluster::set(self : ChemmolpropstpsaCluster, i : Int, v : Double) -> ChemmolpropstpsaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaCluster::sum(self : ChemmolpropstpsaCluster) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropstpsaCluster::mean(self : ChemmolpropstpsaCluster) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropstpsaCluster::scale(self : ChemmolpropstpsaCluster, f : Double) -> ChemmolpropstpsaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaCluster::add(self : ChemmolpropstpsaCluster, other : ChemmolpropstpsaCluster) -> ChemmolpropstpsaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropstpsaCluster::copy(self : ChemmolpropstpsaCluster) -> ChemmolpropstpsaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaCluster::fill(self : ChemmolpropstpsaCluster, v : Double) -> ChemmolpropstpsaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaCluster::min(self : ChemmolpropstpsaCluster) -> Double { @_common.min(self.data) }

pub fn ChemmolpropstpsaCluster::max(self : ChemmolpropstpsaCluster) -> Double { @_common.max(self.data) }

pub fn ChemmolpropstpsaCluster::to_string(self : ChemmolpropstpsaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_model_make(size : Int) -> ChemmolpropstpsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropstpsaModel::len(self : ChemmolpropstpsaModel) -> Int { self.size }

pub fn ChemmolpropstpsaModel::get(self : ChemmolpropstpsaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropstpsaModel::set(self : ChemmolpropstpsaModel, i : Int, v : Double) -> ChemmolpropstpsaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaModel::sum(self : ChemmolpropstpsaModel) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropstpsaModel::mean(self : ChemmolpropstpsaModel) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropstpsaModel::scale(self : ChemmolpropstpsaModel, f : Double) -> ChemmolpropstpsaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaModel::add(self : ChemmolpropstpsaModel, other : ChemmolpropstpsaModel) -> ChemmolpropstpsaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropstpsaModel::copy(self : ChemmolpropstpsaModel) -> ChemmolpropstpsaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaModel::fill(self : ChemmolpropstpsaModel, v : Double) -> ChemmolpropstpsaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaModel::min(self : ChemmolpropstpsaModel) -> Double { @_common.min(self.data) }

pub fn ChemmolpropstpsaModel::max(self : ChemmolpropstpsaModel) -> Double { @_common.max(self.data) }

pub fn ChemmolpropstpsaModel::to_string(self : ChemmolpropstpsaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_layer_make(size : Int) -> ChemmolpropstpsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropstpsaLayer::len(self : ChemmolpropstpsaLayer) -> Int { self.size }

pub fn ChemmolpropstpsaLayer::get(self : ChemmolpropstpsaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropstpsaLayer::set(self : ChemmolpropstpsaLayer, i : Int, v : Double) -> ChemmolpropstpsaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaLayer::sum(self : ChemmolpropstpsaLayer) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropstpsaLayer::mean(self : ChemmolpropstpsaLayer) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropstpsaLayer::scale(self : ChemmolpropstpsaLayer, f : Double) -> ChemmolpropstpsaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaLayer::add(self : ChemmolpropstpsaLayer, other : ChemmolpropstpsaLayer) -> ChemmolpropstpsaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropstpsaLayer::copy(self : ChemmolpropstpsaLayer) -> ChemmolpropstpsaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaLayer::fill(self : ChemmolpropstpsaLayer, v : Double) -> ChemmolpropstpsaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaLayer::min(self : ChemmolpropstpsaLayer) -> Double { @_common.min(self.data) }

pub fn ChemmolpropstpsaLayer::max(self : ChemmolpropstpsaLayer) -> Double { @_common.max(self.data) }

pub fn ChemmolpropstpsaLayer::to_string(self : ChemmolpropstpsaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_buffer_make(size : Int) -> ChemmolpropstpsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropstpsaBuffer::len(self : ChemmolpropstpsaBuffer) -> Int { self.size }

pub fn ChemmolpropstpsaBuffer::get(self : ChemmolpropstpsaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropstpsaBuffer::set(self : ChemmolpropstpsaBuffer, i : Int, v : Double) -> ChemmolpropstpsaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaBuffer::sum(self : ChemmolpropstpsaBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropstpsaBuffer::mean(self : ChemmolpropstpsaBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropstpsaBuffer::scale(self : ChemmolpropstpsaBuffer, f : Double) -> ChemmolpropstpsaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaBuffer::add(self : ChemmolpropstpsaBuffer, other : ChemmolpropstpsaBuffer) -> ChemmolpropstpsaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropstpsaBuffer::copy(self : ChemmolpropstpsaBuffer) -> ChemmolpropstpsaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaBuffer::fill(self : ChemmolpropstpsaBuffer, v : Double) -> ChemmolpropstpsaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaBuffer::min(self : ChemmolpropstpsaBuffer) -> Double { @_common.min(self.data) }

pub fn ChemmolpropstpsaBuffer::max(self : ChemmolpropstpsaBuffer) -> Double { @_common.max(self.data) }

pub fn ChemmolpropstpsaBuffer::to_string(self : ChemmolpropstpsaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_cursor_make(size : Int) -> ChemmolpropstpsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropstpsaCursor::len(self : ChemmolpropstpsaCursor) -> Int { self.size }

pub fn ChemmolpropstpsaCursor::get(self : ChemmolpropstpsaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropstpsaCursor::set(self : ChemmolpropstpsaCursor, i : Int, v : Double) -> ChemmolpropstpsaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaCursor::sum(self : ChemmolpropstpsaCursor) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropstpsaCursor::mean(self : ChemmolpropstpsaCursor) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropstpsaCursor::scale(self : ChemmolpropstpsaCursor, f : Double) -> ChemmolpropstpsaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaCursor::add(self : ChemmolpropstpsaCursor, other : ChemmolpropstpsaCursor) -> ChemmolpropstpsaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropstpsaCursor::copy(self : ChemmolpropstpsaCursor) -> ChemmolpropstpsaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaCursor::fill(self : ChemmolpropstpsaCursor, v : Double) -> ChemmolpropstpsaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaCursor::min(self : ChemmolpropstpsaCursor) -> Double { @_common.min(self.data) }

pub fn ChemmolpropstpsaCursor::max(self : ChemmolpropstpsaCursor) -> Double { @_common.max(self.data) }

pub fn ChemmolpropstpsaCursor::to_string(self : ChemmolpropstpsaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_view_make(size : Int) -> ChemmolpropstpsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropstpsaView::len(self : ChemmolpropstpsaView) -> Int { self.size }

pub fn ChemmolpropstpsaView::get(self : ChemmolpropstpsaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropstpsaView::set(self : ChemmolpropstpsaView, i : Int, v : Double) -> ChemmolpropstpsaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaView::sum(self : ChemmolpropstpsaView) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropstpsaView::mean(self : ChemmolpropstpsaView) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropstpsaView::scale(self : ChemmolpropstpsaView, f : Double) -> ChemmolpropstpsaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaView::add(self : ChemmolpropstpsaView, other : ChemmolpropstpsaView) -> ChemmolpropstpsaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropstpsaView::copy(self : ChemmolpropstpsaView) -> ChemmolpropstpsaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaView::fill(self : ChemmolpropstpsaView, v : Double) -> ChemmolpropstpsaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaView::min(self : ChemmolpropstpsaView) -> Double { @_common.min(self.data) }

pub fn ChemmolpropstpsaView::max(self : ChemmolpropstpsaView) -> Double { @_common.max(self.data) }

pub fn ChemmolpropstpsaView::to_string(self : ChemmolpropstpsaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_range_make(size : Int) -> ChemmolpropstpsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropstpsaRange::len(self : ChemmolpropstpsaRange) -> Int { self.size }

pub fn ChemmolpropstpsaRange::get(self : ChemmolpropstpsaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropstpsaRange::set(self : ChemmolpropstpsaRange, i : Int, v : Double) -> ChemmolpropstpsaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaRange::sum(self : ChemmolpropstpsaRange) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropstpsaRange::mean(self : ChemmolpropstpsaRange) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropstpsaRange::scale(self : ChemmolpropstpsaRange, f : Double) -> ChemmolpropstpsaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaRange::add(self : ChemmolpropstpsaRange, other : ChemmolpropstpsaRange) -> ChemmolpropstpsaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropstpsaRange::copy(self : ChemmolpropstpsaRange) -> ChemmolpropstpsaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaRange::fill(self : ChemmolpropstpsaRange, v : Double) -> ChemmolpropstpsaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaRange::min(self : ChemmolpropstpsaRange) -> Double { @_common.min(self.data) }

pub fn ChemmolpropstpsaRange::max(self : ChemmolpropstpsaRange) -> Double { @_common.max(self.data) }

pub fn ChemmolpropstpsaRange::to_string(self : ChemmolpropstpsaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_slice_make(size : Int) -> ChemmolpropstpsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropstpsaSlice::len(self : ChemmolpropstpsaSlice) -> Int { self.size }

pub fn ChemmolpropstpsaSlice::get(self : ChemmolpropstpsaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropstpsaSlice::set(self : ChemmolpropstpsaSlice, i : Int, v : Double) -> ChemmolpropstpsaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaSlice::sum(self : ChemmolpropstpsaSlice) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropstpsaSlice::mean(self : ChemmolpropstpsaSlice) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropstpsaSlice::scale(self : ChemmolpropstpsaSlice, f : Double) -> ChemmolpropstpsaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaSlice::add(self : ChemmolpropstpsaSlice, other : ChemmolpropstpsaSlice) -> ChemmolpropstpsaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropstpsaSlice::copy(self : ChemmolpropstpsaSlice) -> ChemmolpropstpsaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaSlice::fill(self : ChemmolpropstpsaSlice, v : Double) -> ChemmolpropstpsaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropstpsaSlice::min(self : ChemmolpropstpsaSlice) -> Double { @_common.min(self.data) }

pub fn ChemmolpropstpsaSlice::max(self : ChemmolpropstpsaSlice) -> Double { @_common.max(self.data) }

pub fn ChemmolpropstpsaSlice::to_string(self : ChemmolpropstpsaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

