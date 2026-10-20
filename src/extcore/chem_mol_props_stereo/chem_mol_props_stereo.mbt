///===
/// extcore/chem_mol_props_stereo

pub(all) struct ChemmolpropsstereoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_stereo_make_point(x : Double, y : Double) -> ChemmolpropsstereoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_stereo_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropsstereoPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolpropsstereoPoint::x(self : ChemmolpropsstereoPoint) -> Double { self.x }

pub fn ChemmolpropsstereoPoint::y(self : ChemmolpropsstereoPoint) -> Double { self.y }

pub fn ChemmolpropsstereoPoint::z(self : ChemmolpropsstereoPoint) -> Double { self.z }

pub fn ChemmolpropsstereoPoint::label(self : ChemmolpropsstereoPoint) -> Int { self.label }

pub fn ChemmolpropsstereoPoint::dist(self : ChemmolpropsstereoPoint, other : ChemmolpropsstereoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolpropsstereoPoint::add(self : ChemmolpropsstereoPoint, other : ChemmolpropsstereoPoint) -> ChemmolpropsstereoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolpropsstereoPoint::sub(self : ChemmolpropsstereoPoint, other : ChemmolpropsstereoPoint) -> ChemmolpropsstereoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolpropsstereoPoint::scale(self : ChemmolpropsstereoPoint, s : Double) -> ChemmolpropsstereoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolpropsstereoPoint::dot(self : ChemmolpropsstereoPoint, other : ChemmolpropsstereoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolpropsstereoPoint::cross(self : ChemmolpropsstereoPoint, other : ChemmolpropsstereoPoint) -> ChemmolpropsstereoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolpropsstereoPoint::norm(self : ChemmolpropsstereoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolpropsstereoPoint::normalize(self : ChemmolpropsstereoPoint) -> ChemmolpropsstereoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropsstereoPoint::negate(self : ChemmolpropsstereoPoint) -> ChemmolpropsstereoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolpropsstereoPoint::mid(self : ChemmolpropsstereoPoint, other : ChemmolpropsstereoPoint) -> ChemmolpropsstereoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolpropsstereoPoint::lerp(self : ChemmolpropsstereoPoint, other : ChemmolpropsstereoPoint, t : Double) -> ChemmolpropsstereoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolpropsstereoPoint::to_string(self : ChemmolpropsstereoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_stereo_make_series(vals : Array[Double], name : String) -> ChemmolpropsstereoSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolpropsstereoSeries::len(self : ChemmolpropsstereoSeries) -> Int { self.vals.length() }

pub fn ChemmolpropsstereoSeries::sum(self : ChemmolpropsstereoSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolpropsstereoSeries::mean(self : ChemmolpropsstereoSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolpropsstereoSeries::min(self : ChemmolpropsstereoSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolpropsstereoSeries::max(self : ChemmolpropsstereoSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolpropsstereoSeries::range(self : ChemmolpropsstereoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolpropsstereoSeries::variance(self : ChemmolpropsstereoSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolpropsstereoSeries::std(self : ChemmolpropsstereoSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolpropsstereoSeries::median(self : ChemmolpropsstereoSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolpropsstereoSeries::scale(self : ChemmolpropsstereoSeries, f : Double) -> ChemmolpropsstereoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolpropsstereoSeries::add(self : ChemmolpropsstereoSeries, other : ChemmolpropsstereoSeries) -> ChemmolpropsstereoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolpropsstereoSeries::sub(self : ChemmolpropsstereoSeries, other : ChemmolpropsstereoSeries) -> ChemmolpropsstereoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolpropsstereoSeries::normalize(self : ChemmolpropsstereoSeries) -> ChemmolpropsstereoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolpropsstereoSeries::cumsum(self : ChemmolpropsstereoSeries) -> ChemmolpropsstereoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolpropsstereoSeries::to_string(self : ChemmolpropsstereoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropsstereoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_stereo_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropsstereoMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn chem_mol_props_stereo_matrix_identity(n : Int) -> ChemmolpropsstereoMatrix {
  let m = chem_mol_props_stereo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolpropsstereoMatrix::get(self : ChemmolpropsstereoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolpropsstereoMatrix::transpose(self : ChemmolpropsstereoMatrix) -> ChemmolpropsstereoMatrix {
  let result = chem_mol_props_stereo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolpropsstereoMatrix::add(self : ChemmolpropsstereoMatrix, other : ChemmolpropsstereoMatrix) -> ChemmolpropsstereoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_props_stereo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolpropsstereoMatrix::scale(self : ChemmolpropsstereoMatrix, s : Double) -> ChemmolpropsstereoMatrix {
  let result = chem_mol_props_stereo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolpropsstereoMatrix::multiply(self : ChemmolpropsstereoMatrix, other : ChemmolpropsstereoMatrix) -> ChemmolpropsstereoMatrix {
  if self.cols != other.rows { return chem_mol_props_stereo_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_props_stereo_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ChemmolpropsstereoMatrix::trace(self : ChemmolpropsstereoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolpropsstereoMatrix::det(self : ChemmolpropsstereoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolpropsstereoMatrix::norm(self : ChemmolpropsstereoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolpropsstereoMatrix::to_string(self : ChemmolpropsstereoMatrix) -> String {
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

pub(all) struct ChemmolpropsstereoVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_stereo_make_vector(comps : Array[Double]) -> ChemmolpropsstereoVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_stereo_vector_zero(dim : Int) -> ChemmolpropsstereoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolpropsstereoVector::add(self : ChemmolpropsstereoVector, other : ChemmolpropsstereoVector) -> ChemmolpropsstereoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropsstereoVector::sub(self : ChemmolpropsstereoVector, other : ChemmolpropsstereoVector) -> ChemmolpropsstereoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropsstereoVector::scale(self : ChemmolpropsstereoVector, s : Double) -> ChemmolpropsstereoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolpropsstereoVector::dot(self : ChemmolpropsstereoVector, other : ChemmolpropsstereoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolpropsstereoVector::norm(self : ChemmolpropsstereoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolpropsstereoVector::normalize(self : ChemmolpropsstereoVector) -> ChemmolpropsstereoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropsstereoVector::dist(self : ChemmolpropsstereoVector, other : ChemmolpropsstereoVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolpropsstereoVector::to_string(self : ChemmolpropsstereoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropsstereoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_frame_make(size : Int) -> ChemmolpropsstereoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsstereoFrame::len(self : ChemmolpropsstereoFrame) -> Int { self.size }

pub fn ChemmolpropsstereoFrame::get(self : ChemmolpropsstereoFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsstereoFrame::set(self : ChemmolpropsstereoFrame, i : Int, v : Double) -> ChemmolpropsstereoFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoFrame::sum(self : ChemmolpropsstereoFrame) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsstereoFrame::mean(self : ChemmolpropsstereoFrame) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsstereoFrame::scale(self : ChemmolpropsstereoFrame, f : Double) -> ChemmolpropsstereoFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoFrame::add(self : ChemmolpropsstereoFrame, other : ChemmolpropsstereoFrame) -> ChemmolpropsstereoFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsstereoFrame::copy(self : ChemmolpropsstereoFrame) -> ChemmolpropsstereoFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoFrame::fill(self : ChemmolpropsstereoFrame, v : Double) -> ChemmolpropsstereoFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoFrame::min(self : ChemmolpropsstereoFrame) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsstereoFrame::max(self : ChemmolpropsstereoFrame) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsstereoFrame::to_string(self : ChemmolpropsstereoFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_table_make(size : Int) -> ChemmolpropsstereoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsstereoTable::len(self : ChemmolpropsstereoTable) -> Int { self.size }

pub fn ChemmolpropsstereoTable::get(self : ChemmolpropsstereoTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsstereoTable::set(self : ChemmolpropsstereoTable, i : Int, v : Double) -> ChemmolpropsstereoTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoTable::sum(self : ChemmolpropsstereoTable) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsstereoTable::mean(self : ChemmolpropsstereoTable) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsstereoTable::scale(self : ChemmolpropsstereoTable, f : Double) -> ChemmolpropsstereoTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoTable::add(self : ChemmolpropsstereoTable, other : ChemmolpropsstereoTable) -> ChemmolpropsstereoTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsstereoTable::copy(self : ChemmolpropsstereoTable) -> ChemmolpropsstereoTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoTable::fill(self : ChemmolpropsstereoTable, v : Double) -> ChemmolpropsstereoTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoTable::min(self : ChemmolpropsstereoTable) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsstereoTable::max(self : ChemmolpropsstereoTable) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsstereoTable::to_string(self : ChemmolpropsstereoTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_graphn_make(size : Int) -> ChemmolpropsstereoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsstereoGraphN::len(self : ChemmolpropsstereoGraphN) -> Int { self.size }

pub fn ChemmolpropsstereoGraphN::get(self : ChemmolpropsstereoGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsstereoGraphN::set(self : ChemmolpropsstereoGraphN, i : Int, v : Double) -> ChemmolpropsstereoGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoGraphN::sum(self : ChemmolpropsstereoGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsstereoGraphN::mean(self : ChemmolpropsstereoGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsstereoGraphN::scale(self : ChemmolpropsstereoGraphN, f : Double) -> ChemmolpropsstereoGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoGraphN::add(self : ChemmolpropsstereoGraphN, other : ChemmolpropsstereoGraphN) -> ChemmolpropsstereoGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsstereoGraphN::copy(self : ChemmolpropsstereoGraphN) -> ChemmolpropsstereoGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoGraphN::fill(self : ChemmolpropsstereoGraphN, v : Double) -> ChemmolpropsstereoGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoGraphN::min(self : ChemmolpropsstereoGraphN) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsstereoGraphN::max(self : ChemmolpropsstereoGraphN) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsstereoGraphN::to_string(self : ChemmolpropsstereoGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_node_make(size : Int) -> ChemmolpropsstereoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsstereoNode::len(self : ChemmolpropsstereoNode) -> Int { self.size }

pub fn ChemmolpropsstereoNode::get(self : ChemmolpropsstereoNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsstereoNode::set(self : ChemmolpropsstereoNode, i : Int, v : Double) -> ChemmolpropsstereoNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoNode::sum(self : ChemmolpropsstereoNode) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsstereoNode::mean(self : ChemmolpropsstereoNode) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsstereoNode::scale(self : ChemmolpropsstereoNode, f : Double) -> ChemmolpropsstereoNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoNode::add(self : ChemmolpropsstereoNode, other : ChemmolpropsstereoNode) -> ChemmolpropsstereoNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsstereoNode::copy(self : ChemmolpropsstereoNode) -> ChemmolpropsstereoNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoNode::fill(self : ChemmolpropsstereoNode, v : Double) -> ChemmolpropsstereoNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoNode::min(self : ChemmolpropsstereoNode) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsstereoNode::max(self : ChemmolpropsstereoNode) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsstereoNode::to_string(self : ChemmolpropsstereoNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_edge_make(size : Int) -> ChemmolpropsstereoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsstereoEdge::len(self : ChemmolpropsstereoEdge) -> Int { self.size }

pub fn ChemmolpropsstereoEdge::get(self : ChemmolpropsstereoEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsstereoEdge::set(self : ChemmolpropsstereoEdge, i : Int, v : Double) -> ChemmolpropsstereoEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoEdge::sum(self : ChemmolpropsstereoEdge) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsstereoEdge::mean(self : ChemmolpropsstereoEdge) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsstereoEdge::scale(self : ChemmolpropsstereoEdge, f : Double) -> ChemmolpropsstereoEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoEdge::add(self : ChemmolpropsstereoEdge, other : ChemmolpropsstereoEdge) -> ChemmolpropsstereoEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsstereoEdge::copy(self : ChemmolpropsstereoEdge) -> ChemmolpropsstereoEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoEdge::fill(self : ChemmolpropsstereoEdge, v : Double) -> ChemmolpropsstereoEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoEdge::min(self : ChemmolpropsstereoEdge) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsstereoEdge::max(self : ChemmolpropsstereoEdge) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsstereoEdge::to_string(self : ChemmolpropsstereoEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_path_make(size : Int) -> ChemmolpropsstereoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsstereoPath::len(self : ChemmolpropsstereoPath) -> Int { self.size }

pub fn ChemmolpropsstereoPath::get(self : ChemmolpropsstereoPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsstereoPath::set(self : ChemmolpropsstereoPath, i : Int, v : Double) -> ChemmolpropsstereoPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoPath::sum(self : ChemmolpropsstereoPath) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsstereoPath::mean(self : ChemmolpropsstereoPath) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsstereoPath::scale(self : ChemmolpropsstereoPath, f : Double) -> ChemmolpropsstereoPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoPath::add(self : ChemmolpropsstereoPath, other : ChemmolpropsstereoPath) -> ChemmolpropsstereoPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsstereoPath::copy(self : ChemmolpropsstereoPath) -> ChemmolpropsstereoPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoPath::fill(self : ChemmolpropsstereoPath, v : Double) -> ChemmolpropsstereoPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoPath::min(self : ChemmolpropsstereoPath) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsstereoPath::max(self : ChemmolpropsstereoPath) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsstereoPath::to_string(self : ChemmolpropsstereoPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_cluster_make(size : Int) -> ChemmolpropsstereoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsstereoCluster::len(self : ChemmolpropsstereoCluster) -> Int { self.size }

pub fn ChemmolpropsstereoCluster::get(self : ChemmolpropsstereoCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsstereoCluster::set(self : ChemmolpropsstereoCluster, i : Int, v : Double) -> ChemmolpropsstereoCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoCluster::sum(self : ChemmolpropsstereoCluster) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsstereoCluster::mean(self : ChemmolpropsstereoCluster) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsstereoCluster::scale(self : ChemmolpropsstereoCluster, f : Double) -> ChemmolpropsstereoCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoCluster::add(self : ChemmolpropsstereoCluster, other : ChemmolpropsstereoCluster) -> ChemmolpropsstereoCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsstereoCluster::copy(self : ChemmolpropsstereoCluster) -> ChemmolpropsstereoCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoCluster::fill(self : ChemmolpropsstereoCluster, v : Double) -> ChemmolpropsstereoCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoCluster::min(self : ChemmolpropsstereoCluster) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsstereoCluster::max(self : ChemmolpropsstereoCluster) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsstereoCluster::to_string(self : ChemmolpropsstereoCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_model_make(size : Int) -> ChemmolpropsstereoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsstereoModel::len(self : ChemmolpropsstereoModel) -> Int { self.size }

pub fn ChemmolpropsstereoModel::get(self : ChemmolpropsstereoModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsstereoModel::set(self : ChemmolpropsstereoModel, i : Int, v : Double) -> ChemmolpropsstereoModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoModel::sum(self : ChemmolpropsstereoModel) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsstereoModel::mean(self : ChemmolpropsstereoModel) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsstereoModel::scale(self : ChemmolpropsstereoModel, f : Double) -> ChemmolpropsstereoModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoModel::add(self : ChemmolpropsstereoModel, other : ChemmolpropsstereoModel) -> ChemmolpropsstereoModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsstereoModel::copy(self : ChemmolpropsstereoModel) -> ChemmolpropsstereoModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoModel::fill(self : ChemmolpropsstereoModel, v : Double) -> ChemmolpropsstereoModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoModel::min(self : ChemmolpropsstereoModel) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsstereoModel::max(self : ChemmolpropsstereoModel) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsstereoModel::to_string(self : ChemmolpropsstereoModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_layer_make(size : Int) -> ChemmolpropsstereoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsstereoLayer::len(self : ChemmolpropsstereoLayer) -> Int { self.size }

pub fn ChemmolpropsstereoLayer::get(self : ChemmolpropsstereoLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsstereoLayer::set(self : ChemmolpropsstereoLayer, i : Int, v : Double) -> ChemmolpropsstereoLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoLayer::sum(self : ChemmolpropsstereoLayer) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsstereoLayer::mean(self : ChemmolpropsstereoLayer) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsstereoLayer::scale(self : ChemmolpropsstereoLayer, f : Double) -> ChemmolpropsstereoLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoLayer::add(self : ChemmolpropsstereoLayer, other : ChemmolpropsstereoLayer) -> ChemmolpropsstereoLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsstereoLayer::copy(self : ChemmolpropsstereoLayer) -> ChemmolpropsstereoLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoLayer::fill(self : ChemmolpropsstereoLayer, v : Double) -> ChemmolpropsstereoLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoLayer::min(self : ChemmolpropsstereoLayer) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsstereoLayer::max(self : ChemmolpropsstereoLayer) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsstereoLayer::to_string(self : ChemmolpropsstereoLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_buffer_make(size : Int) -> ChemmolpropsstereoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsstereoBuffer::len(self : ChemmolpropsstereoBuffer) -> Int { self.size }

pub fn ChemmolpropsstereoBuffer::get(self : ChemmolpropsstereoBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsstereoBuffer::set(self : ChemmolpropsstereoBuffer, i : Int, v : Double) -> ChemmolpropsstereoBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoBuffer::sum(self : ChemmolpropsstereoBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsstereoBuffer::mean(self : ChemmolpropsstereoBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsstereoBuffer::scale(self : ChemmolpropsstereoBuffer, f : Double) -> ChemmolpropsstereoBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoBuffer::add(self : ChemmolpropsstereoBuffer, other : ChemmolpropsstereoBuffer) -> ChemmolpropsstereoBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsstereoBuffer::copy(self : ChemmolpropsstereoBuffer) -> ChemmolpropsstereoBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoBuffer::fill(self : ChemmolpropsstereoBuffer, v : Double) -> ChemmolpropsstereoBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoBuffer::min(self : ChemmolpropsstereoBuffer) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsstereoBuffer::max(self : ChemmolpropsstereoBuffer) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsstereoBuffer::to_string(self : ChemmolpropsstereoBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_cursor_make(size : Int) -> ChemmolpropsstereoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsstereoCursor::len(self : ChemmolpropsstereoCursor) -> Int { self.size }

pub fn ChemmolpropsstereoCursor::get(self : ChemmolpropsstereoCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsstereoCursor::set(self : ChemmolpropsstereoCursor, i : Int, v : Double) -> ChemmolpropsstereoCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoCursor::sum(self : ChemmolpropsstereoCursor) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsstereoCursor::mean(self : ChemmolpropsstereoCursor) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsstereoCursor::scale(self : ChemmolpropsstereoCursor, f : Double) -> ChemmolpropsstereoCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoCursor::add(self : ChemmolpropsstereoCursor, other : ChemmolpropsstereoCursor) -> ChemmolpropsstereoCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsstereoCursor::copy(self : ChemmolpropsstereoCursor) -> ChemmolpropsstereoCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoCursor::fill(self : ChemmolpropsstereoCursor, v : Double) -> ChemmolpropsstereoCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoCursor::min(self : ChemmolpropsstereoCursor) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsstereoCursor::max(self : ChemmolpropsstereoCursor) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsstereoCursor::to_string(self : ChemmolpropsstereoCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_view_make(size : Int) -> ChemmolpropsstereoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsstereoView::len(self : ChemmolpropsstereoView) -> Int { self.size }

pub fn ChemmolpropsstereoView::get(self : ChemmolpropsstereoView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsstereoView::set(self : ChemmolpropsstereoView, i : Int, v : Double) -> ChemmolpropsstereoView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoView::sum(self : ChemmolpropsstereoView) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsstereoView::mean(self : ChemmolpropsstereoView) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsstereoView::scale(self : ChemmolpropsstereoView, f : Double) -> ChemmolpropsstereoView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoView::add(self : ChemmolpropsstereoView, other : ChemmolpropsstereoView) -> ChemmolpropsstereoView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsstereoView::copy(self : ChemmolpropsstereoView) -> ChemmolpropsstereoView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoView::fill(self : ChemmolpropsstereoView, v : Double) -> ChemmolpropsstereoView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoView::min(self : ChemmolpropsstereoView) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsstereoView::max(self : ChemmolpropsstereoView) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsstereoView::to_string(self : ChemmolpropsstereoView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_range_make(size : Int) -> ChemmolpropsstereoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsstereoRange::len(self : ChemmolpropsstereoRange) -> Int { self.size }

pub fn ChemmolpropsstereoRange::get(self : ChemmolpropsstereoRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsstereoRange::set(self : ChemmolpropsstereoRange, i : Int, v : Double) -> ChemmolpropsstereoRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoRange::sum(self : ChemmolpropsstereoRange) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsstereoRange::mean(self : ChemmolpropsstereoRange) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsstereoRange::scale(self : ChemmolpropsstereoRange, f : Double) -> ChemmolpropsstereoRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoRange::add(self : ChemmolpropsstereoRange, other : ChemmolpropsstereoRange) -> ChemmolpropsstereoRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsstereoRange::copy(self : ChemmolpropsstereoRange) -> ChemmolpropsstereoRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoRange::fill(self : ChemmolpropsstereoRange, v : Double) -> ChemmolpropsstereoRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoRange::min(self : ChemmolpropsstereoRange) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsstereoRange::max(self : ChemmolpropsstereoRange) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsstereoRange::to_string(self : ChemmolpropsstereoRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsstereoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_stereo_slice_make(size : Int) -> ChemmolpropsstereoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsstereoSlice::len(self : ChemmolpropsstereoSlice) -> Int { self.size }

pub fn ChemmolpropsstereoSlice::get(self : ChemmolpropsstereoSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsstereoSlice::set(self : ChemmolpropsstereoSlice, i : Int, v : Double) -> ChemmolpropsstereoSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoSlice::sum(self : ChemmolpropsstereoSlice) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsstereoSlice::mean(self : ChemmolpropsstereoSlice) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsstereoSlice::scale(self : ChemmolpropsstereoSlice, f : Double) -> ChemmolpropsstereoSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoSlice::add(self : ChemmolpropsstereoSlice, other : ChemmolpropsstereoSlice) -> ChemmolpropsstereoSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsstereoSlice::copy(self : ChemmolpropsstereoSlice) -> ChemmolpropsstereoSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoSlice::fill(self : ChemmolpropsstereoSlice, v : Double) -> ChemmolpropsstereoSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsstereoSlice::min(self : ChemmolpropsstereoSlice) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsstereoSlice::max(self : ChemmolpropsstereoSlice) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsstereoSlice::to_string(self : ChemmolpropsstereoSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

