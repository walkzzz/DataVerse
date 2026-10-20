///===
/// extcore/chem_mol_props_aromatic

pub(all) struct ChemmolpropsaromaticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_aromatic_make_point(x : Double, y : Double) -> ChemmolpropsaromaticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_aromatic_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropsaromaticPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolpropsaromaticPoint::x(self : ChemmolpropsaromaticPoint) -> Double { self.x }

pub fn ChemmolpropsaromaticPoint::y(self : ChemmolpropsaromaticPoint) -> Double { self.y }

pub fn ChemmolpropsaromaticPoint::z(self : ChemmolpropsaromaticPoint) -> Double { self.z }

pub fn ChemmolpropsaromaticPoint::label(self : ChemmolpropsaromaticPoint) -> Int { self.label }

pub fn ChemmolpropsaromaticPoint::dist(self : ChemmolpropsaromaticPoint, other : ChemmolpropsaromaticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolpropsaromaticPoint::add(self : ChemmolpropsaromaticPoint, other : ChemmolpropsaromaticPoint) -> ChemmolpropsaromaticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolpropsaromaticPoint::sub(self : ChemmolpropsaromaticPoint, other : ChemmolpropsaromaticPoint) -> ChemmolpropsaromaticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolpropsaromaticPoint::scale(self : ChemmolpropsaromaticPoint, s : Double) -> ChemmolpropsaromaticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolpropsaromaticPoint::dot(self : ChemmolpropsaromaticPoint, other : ChemmolpropsaromaticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolpropsaromaticPoint::cross(self : ChemmolpropsaromaticPoint, other : ChemmolpropsaromaticPoint) -> ChemmolpropsaromaticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolpropsaromaticPoint::norm(self : ChemmolpropsaromaticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolpropsaromaticPoint::normalize(self : ChemmolpropsaromaticPoint) -> ChemmolpropsaromaticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropsaromaticPoint::negate(self : ChemmolpropsaromaticPoint) -> ChemmolpropsaromaticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolpropsaromaticPoint::mid(self : ChemmolpropsaromaticPoint, other : ChemmolpropsaromaticPoint) -> ChemmolpropsaromaticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolpropsaromaticPoint::lerp(self : ChemmolpropsaromaticPoint, other : ChemmolpropsaromaticPoint, t : Double) -> ChemmolpropsaromaticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolpropsaromaticPoint::to_string(self : ChemmolpropsaromaticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_aromatic_make_series(vals : Array[Double], name : String) -> ChemmolpropsaromaticSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolpropsaromaticSeries::len(self : ChemmolpropsaromaticSeries) -> Int { self.vals.length() }

pub fn ChemmolpropsaromaticSeries::sum(self : ChemmolpropsaromaticSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolpropsaromaticSeries::mean(self : ChemmolpropsaromaticSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolpropsaromaticSeries::min(self : ChemmolpropsaromaticSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolpropsaromaticSeries::max(self : ChemmolpropsaromaticSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolpropsaromaticSeries::range(self : ChemmolpropsaromaticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolpropsaromaticSeries::variance(self : ChemmolpropsaromaticSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolpropsaromaticSeries::std(self : ChemmolpropsaromaticSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolpropsaromaticSeries::median(self : ChemmolpropsaromaticSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolpropsaromaticSeries::scale(self : ChemmolpropsaromaticSeries, f : Double) -> ChemmolpropsaromaticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolpropsaromaticSeries::add(self : ChemmolpropsaromaticSeries, other : ChemmolpropsaromaticSeries) -> ChemmolpropsaromaticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolpropsaromaticSeries::sub(self : ChemmolpropsaromaticSeries, other : ChemmolpropsaromaticSeries) -> ChemmolpropsaromaticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolpropsaromaticSeries::normalize(self : ChemmolpropsaromaticSeries) -> ChemmolpropsaromaticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolpropsaromaticSeries::cumsum(self : ChemmolpropsaromaticSeries) -> ChemmolpropsaromaticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolpropsaromaticSeries::to_string(self : ChemmolpropsaromaticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropsaromaticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_aromatic_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropsaromaticMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn chem_mol_props_aromatic_matrix_identity(n : Int) -> ChemmolpropsaromaticMatrix {
  let m = chem_mol_props_aromatic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolpropsaromaticMatrix::get(self : ChemmolpropsaromaticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolpropsaromaticMatrix::transpose(self : ChemmolpropsaromaticMatrix) -> ChemmolpropsaromaticMatrix {
  let result = chem_mol_props_aromatic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolpropsaromaticMatrix::add(self : ChemmolpropsaromaticMatrix, other : ChemmolpropsaromaticMatrix) -> ChemmolpropsaromaticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_props_aromatic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolpropsaromaticMatrix::scale(self : ChemmolpropsaromaticMatrix, s : Double) -> ChemmolpropsaromaticMatrix {
  let result = chem_mol_props_aromatic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolpropsaromaticMatrix::multiply(self : ChemmolpropsaromaticMatrix, other : ChemmolpropsaromaticMatrix) -> ChemmolpropsaromaticMatrix {
  if self.cols != other.rows { return chem_mol_props_aromatic_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_props_aromatic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ChemmolpropsaromaticMatrix::trace(self : ChemmolpropsaromaticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolpropsaromaticMatrix::det(self : ChemmolpropsaromaticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolpropsaromaticMatrix::norm(self : ChemmolpropsaromaticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolpropsaromaticMatrix::to_string(self : ChemmolpropsaromaticMatrix) -> String {
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

pub(all) struct ChemmolpropsaromaticVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_aromatic_make_vector(comps : Array[Double]) -> ChemmolpropsaromaticVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_aromatic_vector_zero(dim : Int) -> ChemmolpropsaromaticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolpropsaromaticVector::add(self : ChemmolpropsaromaticVector, other : ChemmolpropsaromaticVector) -> ChemmolpropsaromaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropsaromaticVector::sub(self : ChemmolpropsaromaticVector, other : ChemmolpropsaromaticVector) -> ChemmolpropsaromaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropsaromaticVector::scale(self : ChemmolpropsaromaticVector, s : Double) -> ChemmolpropsaromaticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolpropsaromaticVector::dot(self : ChemmolpropsaromaticVector, other : ChemmolpropsaromaticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolpropsaromaticVector::norm(self : ChemmolpropsaromaticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolpropsaromaticVector::normalize(self : ChemmolpropsaromaticVector) -> ChemmolpropsaromaticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropsaromaticVector::dist(self : ChemmolpropsaromaticVector, other : ChemmolpropsaromaticVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolpropsaromaticVector::to_string(self : ChemmolpropsaromaticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropsaromaticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_frame_make(size : Int) -> ChemmolpropsaromaticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsaromaticFrame::len(self : ChemmolpropsaromaticFrame) -> Int { self.size }

pub fn ChemmolpropsaromaticFrame::get(self : ChemmolpropsaromaticFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsaromaticFrame::set(self : ChemmolpropsaromaticFrame, i : Int, v : Double) -> ChemmolpropsaromaticFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticFrame::sum(self : ChemmolpropsaromaticFrame) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsaromaticFrame::mean(self : ChemmolpropsaromaticFrame) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsaromaticFrame::scale(self : ChemmolpropsaromaticFrame, f : Double) -> ChemmolpropsaromaticFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticFrame::add(self : ChemmolpropsaromaticFrame, other : ChemmolpropsaromaticFrame) -> ChemmolpropsaromaticFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsaromaticFrame::copy(self : ChemmolpropsaromaticFrame) -> ChemmolpropsaromaticFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticFrame::fill(self : ChemmolpropsaromaticFrame, v : Double) -> ChemmolpropsaromaticFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticFrame::min(self : ChemmolpropsaromaticFrame) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsaromaticFrame::max(self : ChemmolpropsaromaticFrame) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsaromaticFrame::to_string(self : ChemmolpropsaromaticFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_table_make(size : Int) -> ChemmolpropsaromaticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsaromaticTable::len(self : ChemmolpropsaromaticTable) -> Int { self.size }

pub fn ChemmolpropsaromaticTable::get(self : ChemmolpropsaromaticTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsaromaticTable::set(self : ChemmolpropsaromaticTable, i : Int, v : Double) -> ChemmolpropsaromaticTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticTable::sum(self : ChemmolpropsaromaticTable) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsaromaticTable::mean(self : ChemmolpropsaromaticTable) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsaromaticTable::scale(self : ChemmolpropsaromaticTable, f : Double) -> ChemmolpropsaromaticTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticTable::add(self : ChemmolpropsaromaticTable, other : ChemmolpropsaromaticTable) -> ChemmolpropsaromaticTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsaromaticTable::copy(self : ChemmolpropsaromaticTable) -> ChemmolpropsaromaticTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticTable::fill(self : ChemmolpropsaromaticTable, v : Double) -> ChemmolpropsaromaticTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticTable::min(self : ChemmolpropsaromaticTable) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsaromaticTable::max(self : ChemmolpropsaromaticTable) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsaromaticTable::to_string(self : ChemmolpropsaromaticTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_graphn_make(size : Int) -> ChemmolpropsaromaticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsaromaticGraphN::len(self : ChemmolpropsaromaticGraphN) -> Int { self.size }

pub fn ChemmolpropsaromaticGraphN::get(self : ChemmolpropsaromaticGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsaromaticGraphN::set(self : ChemmolpropsaromaticGraphN, i : Int, v : Double) -> ChemmolpropsaromaticGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticGraphN::sum(self : ChemmolpropsaromaticGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsaromaticGraphN::mean(self : ChemmolpropsaromaticGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsaromaticGraphN::scale(self : ChemmolpropsaromaticGraphN, f : Double) -> ChemmolpropsaromaticGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticGraphN::add(self : ChemmolpropsaromaticGraphN, other : ChemmolpropsaromaticGraphN) -> ChemmolpropsaromaticGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsaromaticGraphN::copy(self : ChemmolpropsaromaticGraphN) -> ChemmolpropsaromaticGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticGraphN::fill(self : ChemmolpropsaromaticGraphN, v : Double) -> ChemmolpropsaromaticGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticGraphN::min(self : ChemmolpropsaromaticGraphN) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsaromaticGraphN::max(self : ChemmolpropsaromaticGraphN) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsaromaticGraphN::to_string(self : ChemmolpropsaromaticGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_node_make(size : Int) -> ChemmolpropsaromaticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsaromaticNode::len(self : ChemmolpropsaromaticNode) -> Int { self.size }

pub fn ChemmolpropsaromaticNode::get(self : ChemmolpropsaromaticNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsaromaticNode::set(self : ChemmolpropsaromaticNode, i : Int, v : Double) -> ChemmolpropsaromaticNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticNode::sum(self : ChemmolpropsaromaticNode) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsaromaticNode::mean(self : ChemmolpropsaromaticNode) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsaromaticNode::scale(self : ChemmolpropsaromaticNode, f : Double) -> ChemmolpropsaromaticNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticNode::add(self : ChemmolpropsaromaticNode, other : ChemmolpropsaromaticNode) -> ChemmolpropsaromaticNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsaromaticNode::copy(self : ChemmolpropsaromaticNode) -> ChemmolpropsaromaticNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticNode::fill(self : ChemmolpropsaromaticNode, v : Double) -> ChemmolpropsaromaticNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticNode::min(self : ChemmolpropsaromaticNode) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsaromaticNode::max(self : ChemmolpropsaromaticNode) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsaromaticNode::to_string(self : ChemmolpropsaromaticNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_edge_make(size : Int) -> ChemmolpropsaromaticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsaromaticEdge::len(self : ChemmolpropsaromaticEdge) -> Int { self.size }

pub fn ChemmolpropsaromaticEdge::get(self : ChemmolpropsaromaticEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsaromaticEdge::set(self : ChemmolpropsaromaticEdge, i : Int, v : Double) -> ChemmolpropsaromaticEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticEdge::sum(self : ChemmolpropsaromaticEdge) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsaromaticEdge::mean(self : ChemmolpropsaromaticEdge) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsaromaticEdge::scale(self : ChemmolpropsaromaticEdge, f : Double) -> ChemmolpropsaromaticEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticEdge::add(self : ChemmolpropsaromaticEdge, other : ChemmolpropsaromaticEdge) -> ChemmolpropsaromaticEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsaromaticEdge::copy(self : ChemmolpropsaromaticEdge) -> ChemmolpropsaromaticEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticEdge::fill(self : ChemmolpropsaromaticEdge, v : Double) -> ChemmolpropsaromaticEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticEdge::min(self : ChemmolpropsaromaticEdge) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsaromaticEdge::max(self : ChemmolpropsaromaticEdge) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsaromaticEdge::to_string(self : ChemmolpropsaromaticEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_path_make(size : Int) -> ChemmolpropsaromaticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsaromaticPath::len(self : ChemmolpropsaromaticPath) -> Int { self.size }

pub fn ChemmolpropsaromaticPath::get(self : ChemmolpropsaromaticPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsaromaticPath::set(self : ChemmolpropsaromaticPath, i : Int, v : Double) -> ChemmolpropsaromaticPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticPath::sum(self : ChemmolpropsaromaticPath) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsaromaticPath::mean(self : ChemmolpropsaromaticPath) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsaromaticPath::scale(self : ChemmolpropsaromaticPath, f : Double) -> ChemmolpropsaromaticPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticPath::add(self : ChemmolpropsaromaticPath, other : ChemmolpropsaromaticPath) -> ChemmolpropsaromaticPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsaromaticPath::copy(self : ChemmolpropsaromaticPath) -> ChemmolpropsaromaticPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticPath::fill(self : ChemmolpropsaromaticPath, v : Double) -> ChemmolpropsaromaticPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticPath::min(self : ChemmolpropsaromaticPath) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsaromaticPath::max(self : ChemmolpropsaromaticPath) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsaromaticPath::to_string(self : ChemmolpropsaromaticPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_cluster_make(size : Int) -> ChemmolpropsaromaticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsaromaticCluster::len(self : ChemmolpropsaromaticCluster) -> Int { self.size }

pub fn ChemmolpropsaromaticCluster::get(self : ChemmolpropsaromaticCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsaromaticCluster::set(self : ChemmolpropsaromaticCluster, i : Int, v : Double) -> ChemmolpropsaromaticCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticCluster::sum(self : ChemmolpropsaromaticCluster) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsaromaticCluster::mean(self : ChemmolpropsaromaticCluster) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsaromaticCluster::scale(self : ChemmolpropsaromaticCluster, f : Double) -> ChemmolpropsaromaticCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticCluster::add(self : ChemmolpropsaromaticCluster, other : ChemmolpropsaromaticCluster) -> ChemmolpropsaromaticCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsaromaticCluster::copy(self : ChemmolpropsaromaticCluster) -> ChemmolpropsaromaticCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticCluster::fill(self : ChemmolpropsaromaticCluster, v : Double) -> ChemmolpropsaromaticCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticCluster::min(self : ChemmolpropsaromaticCluster) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsaromaticCluster::max(self : ChemmolpropsaromaticCluster) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsaromaticCluster::to_string(self : ChemmolpropsaromaticCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_model_make(size : Int) -> ChemmolpropsaromaticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsaromaticModel::len(self : ChemmolpropsaromaticModel) -> Int { self.size }

pub fn ChemmolpropsaromaticModel::get(self : ChemmolpropsaromaticModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsaromaticModel::set(self : ChemmolpropsaromaticModel, i : Int, v : Double) -> ChemmolpropsaromaticModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticModel::sum(self : ChemmolpropsaromaticModel) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsaromaticModel::mean(self : ChemmolpropsaromaticModel) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsaromaticModel::scale(self : ChemmolpropsaromaticModel, f : Double) -> ChemmolpropsaromaticModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticModel::add(self : ChemmolpropsaromaticModel, other : ChemmolpropsaromaticModel) -> ChemmolpropsaromaticModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsaromaticModel::copy(self : ChemmolpropsaromaticModel) -> ChemmolpropsaromaticModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticModel::fill(self : ChemmolpropsaromaticModel, v : Double) -> ChemmolpropsaromaticModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticModel::min(self : ChemmolpropsaromaticModel) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsaromaticModel::max(self : ChemmolpropsaromaticModel) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsaromaticModel::to_string(self : ChemmolpropsaromaticModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_layer_make(size : Int) -> ChemmolpropsaromaticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsaromaticLayer::len(self : ChemmolpropsaromaticLayer) -> Int { self.size }

pub fn ChemmolpropsaromaticLayer::get(self : ChemmolpropsaromaticLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsaromaticLayer::set(self : ChemmolpropsaromaticLayer, i : Int, v : Double) -> ChemmolpropsaromaticLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticLayer::sum(self : ChemmolpropsaromaticLayer) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsaromaticLayer::mean(self : ChemmolpropsaromaticLayer) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsaromaticLayer::scale(self : ChemmolpropsaromaticLayer, f : Double) -> ChemmolpropsaromaticLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticLayer::add(self : ChemmolpropsaromaticLayer, other : ChemmolpropsaromaticLayer) -> ChemmolpropsaromaticLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsaromaticLayer::copy(self : ChemmolpropsaromaticLayer) -> ChemmolpropsaromaticLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticLayer::fill(self : ChemmolpropsaromaticLayer, v : Double) -> ChemmolpropsaromaticLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticLayer::min(self : ChemmolpropsaromaticLayer) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsaromaticLayer::max(self : ChemmolpropsaromaticLayer) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsaromaticLayer::to_string(self : ChemmolpropsaromaticLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_buffer_make(size : Int) -> ChemmolpropsaromaticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsaromaticBuffer::len(self : ChemmolpropsaromaticBuffer) -> Int { self.size }

pub fn ChemmolpropsaromaticBuffer::get(self : ChemmolpropsaromaticBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsaromaticBuffer::set(self : ChemmolpropsaromaticBuffer, i : Int, v : Double) -> ChemmolpropsaromaticBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticBuffer::sum(self : ChemmolpropsaromaticBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsaromaticBuffer::mean(self : ChemmolpropsaromaticBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsaromaticBuffer::scale(self : ChemmolpropsaromaticBuffer, f : Double) -> ChemmolpropsaromaticBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticBuffer::add(self : ChemmolpropsaromaticBuffer, other : ChemmolpropsaromaticBuffer) -> ChemmolpropsaromaticBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsaromaticBuffer::copy(self : ChemmolpropsaromaticBuffer) -> ChemmolpropsaromaticBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticBuffer::fill(self : ChemmolpropsaromaticBuffer, v : Double) -> ChemmolpropsaromaticBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticBuffer::min(self : ChemmolpropsaromaticBuffer) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsaromaticBuffer::max(self : ChemmolpropsaromaticBuffer) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsaromaticBuffer::to_string(self : ChemmolpropsaromaticBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_cursor_make(size : Int) -> ChemmolpropsaromaticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsaromaticCursor::len(self : ChemmolpropsaromaticCursor) -> Int { self.size }

pub fn ChemmolpropsaromaticCursor::get(self : ChemmolpropsaromaticCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsaromaticCursor::set(self : ChemmolpropsaromaticCursor, i : Int, v : Double) -> ChemmolpropsaromaticCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticCursor::sum(self : ChemmolpropsaromaticCursor) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsaromaticCursor::mean(self : ChemmolpropsaromaticCursor) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsaromaticCursor::scale(self : ChemmolpropsaromaticCursor, f : Double) -> ChemmolpropsaromaticCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticCursor::add(self : ChemmolpropsaromaticCursor, other : ChemmolpropsaromaticCursor) -> ChemmolpropsaromaticCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsaromaticCursor::copy(self : ChemmolpropsaromaticCursor) -> ChemmolpropsaromaticCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticCursor::fill(self : ChemmolpropsaromaticCursor, v : Double) -> ChemmolpropsaromaticCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticCursor::min(self : ChemmolpropsaromaticCursor) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsaromaticCursor::max(self : ChemmolpropsaromaticCursor) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsaromaticCursor::to_string(self : ChemmolpropsaromaticCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_view_make(size : Int) -> ChemmolpropsaromaticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsaromaticView::len(self : ChemmolpropsaromaticView) -> Int { self.size }

pub fn ChemmolpropsaromaticView::get(self : ChemmolpropsaromaticView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsaromaticView::set(self : ChemmolpropsaromaticView, i : Int, v : Double) -> ChemmolpropsaromaticView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticView::sum(self : ChemmolpropsaromaticView) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsaromaticView::mean(self : ChemmolpropsaromaticView) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsaromaticView::scale(self : ChemmolpropsaromaticView, f : Double) -> ChemmolpropsaromaticView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticView::add(self : ChemmolpropsaromaticView, other : ChemmolpropsaromaticView) -> ChemmolpropsaromaticView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsaromaticView::copy(self : ChemmolpropsaromaticView) -> ChemmolpropsaromaticView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticView::fill(self : ChemmolpropsaromaticView, v : Double) -> ChemmolpropsaromaticView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticView::min(self : ChemmolpropsaromaticView) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsaromaticView::max(self : ChemmolpropsaromaticView) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsaromaticView::to_string(self : ChemmolpropsaromaticView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_range_make(size : Int) -> ChemmolpropsaromaticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsaromaticRange::len(self : ChemmolpropsaromaticRange) -> Int { self.size }

pub fn ChemmolpropsaromaticRange::get(self : ChemmolpropsaromaticRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsaromaticRange::set(self : ChemmolpropsaromaticRange, i : Int, v : Double) -> ChemmolpropsaromaticRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticRange::sum(self : ChemmolpropsaromaticRange) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsaromaticRange::mean(self : ChemmolpropsaromaticRange) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsaromaticRange::scale(self : ChemmolpropsaromaticRange, f : Double) -> ChemmolpropsaromaticRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticRange::add(self : ChemmolpropsaromaticRange, other : ChemmolpropsaromaticRange) -> ChemmolpropsaromaticRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsaromaticRange::copy(self : ChemmolpropsaromaticRange) -> ChemmolpropsaromaticRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticRange::fill(self : ChemmolpropsaromaticRange, v : Double) -> ChemmolpropsaromaticRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticRange::min(self : ChemmolpropsaromaticRange) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsaromaticRange::max(self : ChemmolpropsaromaticRange) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsaromaticRange::to_string(self : ChemmolpropsaromaticRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_slice_make(size : Int) -> ChemmolpropsaromaticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsaromaticSlice::len(self : ChemmolpropsaromaticSlice) -> Int { self.size }

pub fn ChemmolpropsaromaticSlice::get(self : ChemmolpropsaromaticSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsaromaticSlice::set(self : ChemmolpropsaromaticSlice, i : Int, v : Double) -> ChemmolpropsaromaticSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticSlice::sum(self : ChemmolpropsaromaticSlice) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsaromaticSlice::mean(self : ChemmolpropsaromaticSlice) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsaromaticSlice::scale(self : ChemmolpropsaromaticSlice, f : Double) -> ChemmolpropsaromaticSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticSlice::add(self : ChemmolpropsaromaticSlice, other : ChemmolpropsaromaticSlice) -> ChemmolpropsaromaticSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsaromaticSlice::copy(self : ChemmolpropsaromaticSlice) -> ChemmolpropsaromaticSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticSlice::fill(self : ChemmolpropsaromaticSlice, v : Double) -> ChemmolpropsaromaticSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsaromaticSlice::min(self : ChemmolpropsaromaticSlice) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsaromaticSlice::max(self : ChemmolpropsaromaticSlice) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsaromaticSlice::to_string(self : ChemmolpropsaromaticSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

