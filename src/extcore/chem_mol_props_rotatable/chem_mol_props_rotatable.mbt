///===
/// extcore/chem_mol_props_rotatable

pub(all) struct ChemmolpropsrotatablePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_rotatable_make_point(x : Double, y : Double) -> ChemmolpropsrotatablePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_rotatable_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropsrotatablePoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolpropsrotatablePoint::x(self : ChemmolpropsrotatablePoint) -> Double { self.x }

pub fn ChemmolpropsrotatablePoint::y(self : ChemmolpropsrotatablePoint) -> Double { self.y }

pub fn ChemmolpropsrotatablePoint::z(self : ChemmolpropsrotatablePoint) -> Double { self.z }

pub fn ChemmolpropsrotatablePoint::label(self : ChemmolpropsrotatablePoint) -> Int { self.label }

pub fn ChemmolpropsrotatablePoint::dist(self : ChemmolpropsrotatablePoint, other : ChemmolpropsrotatablePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolpropsrotatablePoint::add(self : ChemmolpropsrotatablePoint, other : ChemmolpropsrotatablePoint) -> ChemmolpropsrotatablePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolpropsrotatablePoint::sub(self : ChemmolpropsrotatablePoint, other : ChemmolpropsrotatablePoint) -> ChemmolpropsrotatablePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolpropsrotatablePoint::scale(self : ChemmolpropsrotatablePoint, s : Double) -> ChemmolpropsrotatablePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolpropsrotatablePoint::dot(self : ChemmolpropsrotatablePoint, other : ChemmolpropsrotatablePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolpropsrotatablePoint::cross(self : ChemmolpropsrotatablePoint, other : ChemmolpropsrotatablePoint) -> ChemmolpropsrotatablePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolpropsrotatablePoint::norm(self : ChemmolpropsrotatablePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolpropsrotatablePoint::normalize(self : ChemmolpropsrotatablePoint) -> ChemmolpropsrotatablePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropsrotatablePoint::negate(self : ChemmolpropsrotatablePoint) -> ChemmolpropsrotatablePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolpropsrotatablePoint::mid(self : ChemmolpropsrotatablePoint, other : ChemmolpropsrotatablePoint) -> ChemmolpropsrotatablePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolpropsrotatablePoint::lerp(self : ChemmolpropsrotatablePoint, other : ChemmolpropsrotatablePoint, t : Double) -> ChemmolpropsrotatablePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolpropsrotatablePoint::to_string(self : ChemmolpropsrotatablePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_rotatable_make_series(vals : Array[Double], name : String) -> ChemmolpropsrotatableSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolpropsrotatableSeries::len(self : ChemmolpropsrotatableSeries) -> Int { self.vals.length() }

pub fn ChemmolpropsrotatableSeries::sum(self : ChemmolpropsrotatableSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolpropsrotatableSeries::mean(self : ChemmolpropsrotatableSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolpropsrotatableSeries::min(self : ChemmolpropsrotatableSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolpropsrotatableSeries::max(self : ChemmolpropsrotatableSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolpropsrotatableSeries::range(self : ChemmolpropsrotatableSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolpropsrotatableSeries::variance(self : ChemmolpropsrotatableSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolpropsrotatableSeries::std(self : ChemmolpropsrotatableSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolpropsrotatableSeries::median(self : ChemmolpropsrotatableSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolpropsrotatableSeries::scale(self : ChemmolpropsrotatableSeries, f : Double) -> ChemmolpropsrotatableSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolpropsrotatableSeries::add(self : ChemmolpropsrotatableSeries, other : ChemmolpropsrotatableSeries) -> ChemmolpropsrotatableSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolpropsrotatableSeries::sub(self : ChemmolpropsrotatableSeries, other : ChemmolpropsrotatableSeries) -> ChemmolpropsrotatableSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolpropsrotatableSeries::normalize(self : ChemmolpropsrotatableSeries) -> ChemmolpropsrotatableSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolpropsrotatableSeries::cumsum(self : ChemmolpropsrotatableSeries) -> ChemmolpropsrotatableSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolpropsrotatableSeries::to_string(self : ChemmolpropsrotatableSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropsrotatableMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_rotatable_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropsrotatableMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_rotatable_matrix_identity(n : Int) -> ChemmolpropsrotatableMatrix {
  let m = chem_mol_props_rotatable_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolpropsrotatableMatrix::get(self : ChemmolpropsrotatableMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolpropsrotatableMatrix::transpose(self : ChemmolpropsrotatableMatrix) -> ChemmolpropsrotatableMatrix {
  let result = chem_mol_props_rotatable_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolpropsrotatableMatrix::add(self : ChemmolpropsrotatableMatrix, other : ChemmolpropsrotatableMatrix) -> ChemmolpropsrotatableMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_props_rotatable_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolpropsrotatableMatrix::scale(self : ChemmolpropsrotatableMatrix, s : Double) -> ChemmolpropsrotatableMatrix {
  let result = chem_mol_props_rotatable_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolpropsrotatableMatrix::multiply(self : ChemmolpropsrotatableMatrix, other : ChemmolpropsrotatableMatrix) -> ChemmolpropsrotatableMatrix {
  if self.cols != other.rows { return chem_mol_props_rotatable_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_props_rotatable_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ChemmolpropsrotatableMatrix::trace(self : ChemmolpropsrotatableMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolpropsrotatableMatrix::det(self : ChemmolpropsrotatableMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolpropsrotatableMatrix::norm(self : ChemmolpropsrotatableMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolpropsrotatableMatrix::to_string(self : ChemmolpropsrotatableMatrix) -> String {
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

pub(all) struct ChemmolpropsrotatableVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_rotatable_make_vector(comps : Array[Double]) -> ChemmolpropsrotatableVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_rotatable_vector_zero(dim : Int) -> ChemmolpropsrotatableVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolpropsrotatableVector::add(self : ChemmolpropsrotatableVector, other : ChemmolpropsrotatableVector) -> ChemmolpropsrotatableVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropsrotatableVector::sub(self : ChemmolpropsrotatableVector, other : ChemmolpropsrotatableVector) -> ChemmolpropsrotatableVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropsrotatableVector::scale(self : ChemmolpropsrotatableVector, s : Double) -> ChemmolpropsrotatableVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolpropsrotatableVector::dot(self : ChemmolpropsrotatableVector, other : ChemmolpropsrotatableVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolpropsrotatableVector::norm(self : ChemmolpropsrotatableVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolpropsrotatableVector::normalize(self : ChemmolpropsrotatableVector) -> ChemmolpropsrotatableVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropsrotatableVector::dist(self : ChemmolpropsrotatableVector, other : ChemmolpropsrotatableVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolpropsrotatableVector::to_string(self : ChemmolpropsrotatableVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropsrotatableFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_frame_make(size : Int) -> ChemmolpropsrotatableFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsrotatableFrame::len(self : ChemmolpropsrotatableFrame) -> Int { self.size }

pub fn ChemmolpropsrotatableFrame::get(self : ChemmolpropsrotatableFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsrotatableFrame::set(self : ChemmolpropsrotatableFrame, i : Int, v : Double) -> ChemmolpropsrotatableFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableFrame::sum(self : ChemmolpropsrotatableFrame) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsrotatableFrame::mean(self : ChemmolpropsrotatableFrame) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsrotatableFrame::scale(self : ChemmolpropsrotatableFrame, f : Double) -> ChemmolpropsrotatableFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableFrame::add(self : ChemmolpropsrotatableFrame, other : ChemmolpropsrotatableFrame) -> ChemmolpropsrotatableFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsrotatableFrame::copy(self : ChemmolpropsrotatableFrame) -> ChemmolpropsrotatableFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableFrame::fill(self : ChemmolpropsrotatableFrame, v : Double) -> ChemmolpropsrotatableFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableFrame::min(self : ChemmolpropsrotatableFrame) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsrotatableFrame::max(self : ChemmolpropsrotatableFrame) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsrotatableFrame::to_string(self : ChemmolpropsrotatableFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_table_make(size : Int) -> ChemmolpropsrotatableTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsrotatableTable::len(self : ChemmolpropsrotatableTable) -> Int { self.size }

pub fn ChemmolpropsrotatableTable::get(self : ChemmolpropsrotatableTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsrotatableTable::set(self : ChemmolpropsrotatableTable, i : Int, v : Double) -> ChemmolpropsrotatableTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableTable::sum(self : ChemmolpropsrotatableTable) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsrotatableTable::mean(self : ChemmolpropsrotatableTable) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsrotatableTable::scale(self : ChemmolpropsrotatableTable, f : Double) -> ChemmolpropsrotatableTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableTable::add(self : ChemmolpropsrotatableTable, other : ChemmolpropsrotatableTable) -> ChemmolpropsrotatableTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsrotatableTable::copy(self : ChemmolpropsrotatableTable) -> ChemmolpropsrotatableTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableTable::fill(self : ChemmolpropsrotatableTable, v : Double) -> ChemmolpropsrotatableTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableTable::min(self : ChemmolpropsrotatableTable) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsrotatableTable::max(self : ChemmolpropsrotatableTable) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsrotatableTable::to_string(self : ChemmolpropsrotatableTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_graphn_make(size : Int) -> ChemmolpropsrotatableGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsrotatableGraphN::len(self : ChemmolpropsrotatableGraphN) -> Int { self.size }

pub fn ChemmolpropsrotatableGraphN::get(self : ChemmolpropsrotatableGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsrotatableGraphN::set(self : ChemmolpropsrotatableGraphN, i : Int, v : Double) -> ChemmolpropsrotatableGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableGraphN::sum(self : ChemmolpropsrotatableGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsrotatableGraphN::mean(self : ChemmolpropsrotatableGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsrotatableGraphN::scale(self : ChemmolpropsrotatableGraphN, f : Double) -> ChemmolpropsrotatableGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableGraphN::add(self : ChemmolpropsrotatableGraphN, other : ChemmolpropsrotatableGraphN) -> ChemmolpropsrotatableGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsrotatableGraphN::copy(self : ChemmolpropsrotatableGraphN) -> ChemmolpropsrotatableGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableGraphN::fill(self : ChemmolpropsrotatableGraphN, v : Double) -> ChemmolpropsrotatableGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableGraphN::min(self : ChemmolpropsrotatableGraphN) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsrotatableGraphN::max(self : ChemmolpropsrotatableGraphN) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsrotatableGraphN::to_string(self : ChemmolpropsrotatableGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_node_make(size : Int) -> ChemmolpropsrotatableNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsrotatableNode::len(self : ChemmolpropsrotatableNode) -> Int { self.size }

pub fn ChemmolpropsrotatableNode::get(self : ChemmolpropsrotatableNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsrotatableNode::set(self : ChemmolpropsrotatableNode, i : Int, v : Double) -> ChemmolpropsrotatableNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableNode::sum(self : ChemmolpropsrotatableNode) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsrotatableNode::mean(self : ChemmolpropsrotatableNode) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsrotatableNode::scale(self : ChemmolpropsrotatableNode, f : Double) -> ChemmolpropsrotatableNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableNode::add(self : ChemmolpropsrotatableNode, other : ChemmolpropsrotatableNode) -> ChemmolpropsrotatableNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsrotatableNode::copy(self : ChemmolpropsrotatableNode) -> ChemmolpropsrotatableNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableNode::fill(self : ChemmolpropsrotatableNode, v : Double) -> ChemmolpropsrotatableNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableNode::min(self : ChemmolpropsrotatableNode) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsrotatableNode::max(self : ChemmolpropsrotatableNode) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsrotatableNode::to_string(self : ChemmolpropsrotatableNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_edge_make(size : Int) -> ChemmolpropsrotatableEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsrotatableEdge::len(self : ChemmolpropsrotatableEdge) -> Int { self.size }

pub fn ChemmolpropsrotatableEdge::get(self : ChemmolpropsrotatableEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsrotatableEdge::set(self : ChemmolpropsrotatableEdge, i : Int, v : Double) -> ChemmolpropsrotatableEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableEdge::sum(self : ChemmolpropsrotatableEdge) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsrotatableEdge::mean(self : ChemmolpropsrotatableEdge) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsrotatableEdge::scale(self : ChemmolpropsrotatableEdge, f : Double) -> ChemmolpropsrotatableEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableEdge::add(self : ChemmolpropsrotatableEdge, other : ChemmolpropsrotatableEdge) -> ChemmolpropsrotatableEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsrotatableEdge::copy(self : ChemmolpropsrotatableEdge) -> ChemmolpropsrotatableEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableEdge::fill(self : ChemmolpropsrotatableEdge, v : Double) -> ChemmolpropsrotatableEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableEdge::min(self : ChemmolpropsrotatableEdge) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsrotatableEdge::max(self : ChemmolpropsrotatableEdge) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsrotatableEdge::to_string(self : ChemmolpropsrotatableEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatablePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_path_make(size : Int) -> ChemmolpropsrotatablePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsrotatablePath::len(self : ChemmolpropsrotatablePath) -> Int { self.size }

pub fn ChemmolpropsrotatablePath::get(self : ChemmolpropsrotatablePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsrotatablePath::set(self : ChemmolpropsrotatablePath, i : Int, v : Double) -> ChemmolpropsrotatablePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatablePath::sum(self : ChemmolpropsrotatablePath) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsrotatablePath::mean(self : ChemmolpropsrotatablePath) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsrotatablePath::scale(self : ChemmolpropsrotatablePath, f : Double) -> ChemmolpropsrotatablePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatablePath::add(self : ChemmolpropsrotatablePath, other : ChemmolpropsrotatablePath) -> ChemmolpropsrotatablePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsrotatablePath::copy(self : ChemmolpropsrotatablePath) -> ChemmolpropsrotatablePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatablePath::fill(self : ChemmolpropsrotatablePath, v : Double) -> ChemmolpropsrotatablePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatablePath::min(self : ChemmolpropsrotatablePath) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsrotatablePath::max(self : ChemmolpropsrotatablePath) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsrotatablePath::to_string(self : ChemmolpropsrotatablePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_cluster_make(size : Int) -> ChemmolpropsrotatableCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsrotatableCluster::len(self : ChemmolpropsrotatableCluster) -> Int { self.size }

pub fn ChemmolpropsrotatableCluster::get(self : ChemmolpropsrotatableCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsrotatableCluster::set(self : ChemmolpropsrotatableCluster, i : Int, v : Double) -> ChemmolpropsrotatableCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableCluster::sum(self : ChemmolpropsrotatableCluster) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsrotatableCluster::mean(self : ChemmolpropsrotatableCluster) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsrotatableCluster::scale(self : ChemmolpropsrotatableCluster, f : Double) -> ChemmolpropsrotatableCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableCluster::add(self : ChemmolpropsrotatableCluster, other : ChemmolpropsrotatableCluster) -> ChemmolpropsrotatableCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsrotatableCluster::copy(self : ChemmolpropsrotatableCluster) -> ChemmolpropsrotatableCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableCluster::fill(self : ChemmolpropsrotatableCluster, v : Double) -> ChemmolpropsrotatableCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableCluster::min(self : ChemmolpropsrotatableCluster) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsrotatableCluster::max(self : ChemmolpropsrotatableCluster) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsrotatableCluster::to_string(self : ChemmolpropsrotatableCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_model_make(size : Int) -> ChemmolpropsrotatableModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsrotatableModel::len(self : ChemmolpropsrotatableModel) -> Int { self.size }

pub fn ChemmolpropsrotatableModel::get(self : ChemmolpropsrotatableModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsrotatableModel::set(self : ChemmolpropsrotatableModel, i : Int, v : Double) -> ChemmolpropsrotatableModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableModel::sum(self : ChemmolpropsrotatableModel) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsrotatableModel::mean(self : ChemmolpropsrotatableModel) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsrotatableModel::scale(self : ChemmolpropsrotatableModel, f : Double) -> ChemmolpropsrotatableModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableModel::add(self : ChemmolpropsrotatableModel, other : ChemmolpropsrotatableModel) -> ChemmolpropsrotatableModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsrotatableModel::copy(self : ChemmolpropsrotatableModel) -> ChemmolpropsrotatableModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableModel::fill(self : ChemmolpropsrotatableModel, v : Double) -> ChemmolpropsrotatableModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableModel::min(self : ChemmolpropsrotatableModel) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsrotatableModel::max(self : ChemmolpropsrotatableModel) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsrotatableModel::to_string(self : ChemmolpropsrotatableModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_layer_make(size : Int) -> ChemmolpropsrotatableLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsrotatableLayer::len(self : ChemmolpropsrotatableLayer) -> Int { self.size }

pub fn ChemmolpropsrotatableLayer::get(self : ChemmolpropsrotatableLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsrotatableLayer::set(self : ChemmolpropsrotatableLayer, i : Int, v : Double) -> ChemmolpropsrotatableLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableLayer::sum(self : ChemmolpropsrotatableLayer) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsrotatableLayer::mean(self : ChemmolpropsrotatableLayer) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsrotatableLayer::scale(self : ChemmolpropsrotatableLayer, f : Double) -> ChemmolpropsrotatableLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableLayer::add(self : ChemmolpropsrotatableLayer, other : ChemmolpropsrotatableLayer) -> ChemmolpropsrotatableLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsrotatableLayer::copy(self : ChemmolpropsrotatableLayer) -> ChemmolpropsrotatableLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableLayer::fill(self : ChemmolpropsrotatableLayer, v : Double) -> ChemmolpropsrotatableLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableLayer::min(self : ChemmolpropsrotatableLayer) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsrotatableLayer::max(self : ChemmolpropsrotatableLayer) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsrotatableLayer::to_string(self : ChemmolpropsrotatableLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_buffer_make(size : Int) -> ChemmolpropsrotatableBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsrotatableBuffer::len(self : ChemmolpropsrotatableBuffer) -> Int { self.size }

pub fn ChemmolpropsrotatableBuffer::get(self : ChemmolpropsrotatableBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsrotatableBuffer::set(self : ChemmolpropsrotatableBuffer, i : Int, v : Double) -> ChemmolpropsrotatableBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableBuffer::sum(self : ChemmolpropsrotatableBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsrotatableBuffer::mean(self : ChemmolpropsrotatableBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsrotatableBuffer::scale(self : ChemmolpropsrotatableBuffer, f : Double) -> ChemmolpropsrotatableBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableBuffer::add(self : ChemmolpropsrotatableBuffer, other : ChemmolpropsrotatableBuffer) -> ChemmolpropsrotatableBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsrotatableBuffer::copy(self : ChemmolpropsrotatableBuffer) -> ChemmolpropsrotatableBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableBuffer::fill(self : ChemmolpropsrotatableBuffer, v : Double) -> ChemmolpropsrotatableBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableBuffer::min(self : ChemmolpropsrotatableBuffer) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsrotatableBuffer::max(self : ChemmolpropsrotatableBuffer) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsrotatableBuffer::to_string(self : ChemmolpropsrotatableBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_cursor_make(size : Int) -> ChemmolpropsrotatableCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsrotatableCursor::len(self : ChemmolpropsrotatableCursor) -> Int { self.size }

pub fn ChemmolpropsrotatableCursor::get(self : ChemmolpropsrotatableCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsrotatableCursor::set(self : ChemmolpropsrotatableCursor, i : Int, v : Double) -> ChemmolpropsrotatableCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableCursor::sum(self : ChemmolpropsrotatableCursor) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsrotatableCursor::mean(self : ChemmolpropsrotatableCursor) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsrotatableCursor::scale(self : ChemmolpropsrotatableCursor, f : Double) -> ChemmolpropsrotatableCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableCursor::add(self : ChemmolpropsrotatableCursor, other : ChemmolpropsrotatableCursor) -> ChemmolpropsrotatableCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsrotatableCursor::copy(self : ChemmolpropsrotatableCursor) -> ChemmolpropsrotatableCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableCursor::fill(self : ChemmolpropsrotatableCursor, v : Double) -> ChemmolpropsrotatableCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableCursor::min(self : ChemmolpropsrotatableCursor) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsrotatableCursor::max(self : ChemmolpropsrotatableCursor) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsrotatableCursor::to_string(self : ChemmolpropsrotatableCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_view_make(size : Int) -> ChemmolpropsrotatableView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsrotatableView::len(self : ChemmolpropsrotatableView) -> Int { self.size }

pub fn ChemmolpropsrotatableView::get(self : ChemmolpropsrotatableView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsrotatableView::set(self : ChemmolpropsrotatableView, i : Int, v : Double) -> ChemmolpropsrotatableView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableView::sum(self : ChemmolpropsrotatableView) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsrotatableView::mean(self : ChemmolpropsrotatableView) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsrotatableView::scale(self : ChemmolpropsrotatableView, f : Double) -> ChemmolpropsrotatableView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableView::add(self : ChemmolpropsrotatableView, other : ChemmolpropsrotatableView) -> ChemmolpropsrotatableView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsrotatableView::copy(self : ChemmolpropsrotatableView) -> ChemmolpropsrotatableView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableView::fill(self : ChemmolpropsrotatableView, v : Double) -> ChemmolpropsrotatableView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableView::min(self : ChemmolpropsrotatableView) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsrotatableView::max(self : ChemmolpropsrotatableView) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsrotatableView::to_string(self : ChemmolpropsrotatableView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_range_make(size : Int) -> ChemmolpropsrotatableRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsrotatableRange::len(self : ChemmolpropsrotatableRange) -> Int { self.size }

pub fn ChemmolpropsrotatableRange::get(self : ChemmolpropsrotatableRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsrotatableRange::set(self : ChemmolpropsrotatableRange, i : Int, v : Double) -> ChemmolpropsrotatableRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableRange::sum(self : ChemmolpropsrotatableRange) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsrotatableRange::mean(self : ChemmolpropsrotatableRange) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsrotatableRange::scale(self : ChemmolpropsrotatableRange, f : Double) -> ChemmolpropsrotatableRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableRange::add(self : ChemmolpropsrotatableRange, other : ChemmolpropsrotatableRange) -> ChemmolpropsrotatableRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsrotatableRange::copy(self : ChemmolpropsrotatableRange) -> ChemmolpropsrotatableRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableRange::fill(self : ChemmolpropsrotatableRange, v : Double) -> ChemmolpropsrotatableRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableRange::min(self : ChemmolpropsrotatableRange) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsrotatableRange::max(self : ChemmolpropsrotatableRange) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsrotatableRange::to_string(self : ChemmolpropsrotatableRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_slice_make(size : Int) -> ChemmolpropsrotatableSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsrotatableSlice::len(self : ChemmolpropsrotatableSlice) -> Int { self.size }

pub fn ChemmolpropsrotatableSlice::get(self : ChemmolpropsrotatableSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsrotatableSlice::set(self : ChemmolpropsrotatableSlice, i : Int, v : Double) -> ChemmolpropsrotatableSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableSlice::sum(self : ChemmolpropsrotatableSlice) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsrotatableSlice::mean(self : ChemmolpropsrotatableSlice) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsrotatableSlice::scale(self : ChemmolpropsrotatableSlice, f : Double) -> ChemmolpropsrotatableSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableSlice::add(self : ChemmolpropsrotatableSlice, other : ChemmolpropsrotatableSlice) -> ChemmolpropsrotatableSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsrotatableSlice::copy(self : ChemmolpropsrotatableSlice) -> ChemmolpropsrotatableSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableSlice::fill(self : ChemmolpropsrotatableSlice, v : Double) -> ChemmolpropsrotatableSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsrotatableSlice::min(self : ChemmolpropsrotatableSlice) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsrotatableSlice::max(self : ChemmolpropsrotatableSlice) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsrotatableSlice::to_string(self : ChemmolpropsrotatableSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

