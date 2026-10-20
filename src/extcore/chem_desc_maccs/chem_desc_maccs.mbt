///===
/// extcore/chem_desc_maccs

pub(all) struct ChemdescmaccsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_maccs_make_point(x : Double, y : Double) -> ChemdescmaccsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_maccs_make_point3(x : Double, y : Double, z : Double) -> ChemdescmaccsPoint {
  { x, y, z, label: 0 }
}

pub fn ChemdescmaccsPoint::x(self : ChemdescmaccsPoint) -> Double { self.x }

pub fn ChemdescmaccsPoint::y(self : ChemdescmaccsPoint) -> Double { self.y }

pub fn ChemdescmaccsPoint::z(self : ChemdescmaccsPoint) -> Double { self.z }

pub fn ChemdescmaccsPoint::label(self : ChemdescmaccsPoint) -> Int { self.label }

pub fn ChemdescmaccsPoint::dist(self : ChemdescmaccsPoint, other : ChemdescmaccsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemdescmaccsPoint::add(self : ChemdescmaccsPoint, other : ChemdescmaccsPoint) -> ChemdescmaccsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemdescmaccsPoint::sub(self : ChemdescmaccsPoint, other : ChemdescmaccsPoint) -> ChemdescmaccsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemdescmaccsPoint::scale(self : ChemdescmaccsPoint, s : Double) -> ChemdescmaccsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemdescmaccsPoint::dot(self : ChemdescmaccsPoint, other : ChemdescmaccsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemdescmaccsPoint::cross(self : ChemdescmaccsPoint, other : ChemdescmaccsPoint) -> ChemdescmaccsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemdescmaccsPoint::norm(self : ChemdescmaccsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemdescmaccsPoint::normalize(self : ChemdescmaccsPoint) -> ChemdescmaccsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescmaccsPoint::negate(self : ChemdescmaccsPoint) -> ChemdescmaccsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemdescmaccsPoint::mid(self : ChemdescmaccsPoint, other : ChemdescmaccsPoint) -> ChemdescmaccsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemdescmaccsPoint::lerp(self : ChemdescmaccsPoint, other : ChemdescmaccsPoint, t : Double) -> ChemdescmaccsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemdescmaccsPoint::to_string(self : ChemdescmaccsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemdescmaccsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_maccs_make_series(vals : Array[Double], name : String) -> ChemdescmaccsSeries {
  { vals, name, meta: 0 }
}

pub fn ChemdescmaccsSeries::len(self : ChemdescmaccsSeries) -> Int { self.vals.length() }

pub fn ChemdescmaccsSeries::sum(self : ChemdescmaccsSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemdescmaccsSeries::mean(self : ChemdescmaccsSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemdescmaccsSeries::min(self : ChemdescmaccsSeries) -> Double { @_common.min(self.vals) }

pub fn ChemdescmaccsSeries::max(self : ChemdescmaccsSeries) -> Double { @_common.max(self.vals) }

pub fn ChemdescmaccsSeries::range(self : ChemdescmaccsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemdescmaccsSeries::variance(self : ChemdescmaccsSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemdescmaccsSeries::std(self : ChemdescmaccsSeries) -> Double { @_common.std(self.vals) }

pub fn ChemdescmaccsSeries::median(self : ChemdescmaccsSeries) -> Double { @_common.median(self.vals) }

pub fn ChemdescmaccsSeries::scale(self : ChemdescmaccsSeries, f : Double) -> ChemdescmaccsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemdescmaccsSeries::add(self : ChemdescmaccsSeries, other : ChemdescmaccsSeries) -> ChemdescmaccsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemdescmaccsSeries::sub(self : ChemdescmaccsSeries, other : ChemdescmaccsSeries) -> ChemdescmaccsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemdescmaccsSeries::normalize(self : ChemdescmaccsSeries) -> ChemdescmaccsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemdescmaccsSeries::cumsum(self : ChemdescmaccsSeries) -> ChemdescmaccsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemdescmaccsSeries::to_string(self : ChemdescmaccsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescmaccsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_maccs_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescmaccsMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn chem_desc_maccs_matrix_identity(n : Int) -> ChemdescmaccsMatrix {
  let m = chem_desc_maccs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemdescmaccsMatrix::get(self : ChemdescmaccsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemdescmaccsMatrix::transpose(self : ChemdescmaccsMatrix) -> ChemdescmaccsMatrix {
  let result = chem_desc_maccs_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemdescmaccsMatrix::add(self : ChemdescmaccsMatrix, other : ChemdescmaccsMatrix) -> ChemdescmaccsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_desc_maccs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemdescmaccsMatrix::scale(self : ChemdescmaccsMatrix, s : Double) -> ChemdescmaccsMatrix {
  let result = chem_desc_maccs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemdescmaccsMatrix::multiply(self : ChemdescmaccsMatrix, other : ChemdescmaccsMatrix) -> ChemdescmaccsMatrix {
  if self.cols != other.rows { return chem_desc_maccs_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_desc_maccs_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ChemdescmaccsMatrix::trace(self : ChemdescmaccsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemdescmaccsMatrix::det(self : ChemdescmaccsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemdescmaccsMatrix::norm(self : ChemdescmaccsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemdescmaccsMatrix::to_string(self : ChemdescmaccsMatrix) -> String {
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

pub(all) struct ChemdescmaccsVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_maccs_make_vector(comps : Array[Double]) -> ChemdescmaccsVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_maccs_vector_zero(dim : Int) -> ChemdescmaccsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemdescmaccsVector::add(self : ChemdescmaccsVector, other : ChemdescmaccsVector) -> ChemdescmaccsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescmaccsVector::sub(self : ChemdescmaccsVector, other : ChemdescmaccsVector) -> ChemdescmaccsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescmaccsVector::scale(self : ChemdescmaccsVector, s : Double) -> ChemdescmaccsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemdescmaccsVector::dot(self : ChemdescmaccsVector, other : ChemdescmaccsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemdescmaccsVector::norm(self : ChemdescmaccsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemdescmaccsVector::normalize(self : ChemdescmaccsVector) -> ChemdescmaccsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescmaccsVector::dist(self : ChemdescmaccsVector, other : ChemdescmaccsVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemdescmaccsVector::to_string(self : ChemdescmaccsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescmaccsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_frame_make(size : Int) -> ChemdescmaccsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescmaccsFrame::len(self : ChemdescmaccsFrame) -> Int { self.size }

pub fn ChemdescmaccsFrame::get(self : ChemdescmaccsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescmaccsFrame::set(self : ChemdescmaccsFrame, i : Int, v : Double) -> ChemdescmaccsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsFrame::sum(self : ChemdescmaccsFrame) -> Double { @_common.sum(self.data) }

pub fn ChemdescmaccsFrame::mean(self : ChemdescmaccsFrame) -> Double { @_common.mean(self.data) }

pub fn ChemdescmaccsFrame::scale(self : ChemdescmaccsFrame, f : Double) -> ChemdescmaccsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsFrame::add(self : ChemdescmaccsFrame, other : ChemdescmaccsFrame) -> ChemdescmaccsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescmaccsFrame::copy(self : ChemdescmaccsFrame) -> ChemdescmaccsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsFrame::fill(self : ChemdescmaccsFrame, v : Double) -> ChemdescmaccsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsFrame::min(self : ChemdescmaccsFrame) -> Double { @_common.min(self.data) }

pub fn ChemdescmaccsFrame::max(self : ChemdescmaccsFrame) -> Double { @_common.max(self.data) }

pub fn ChemdescmaccsFrame::to_string(self : ChemdescmaccsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_table_make(size : Int) -> ChemdescmaccsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescmaccsTable::len(self : ChemdescmaccsTable) -> Int { self.size }

pub fn ChemdescmaccsTable::get(self : ChemdescmaccsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescmaccsTable::set(self : ChemdescmaccsTable, i : Int, v : Double) -> ChemdescmaccsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsTable::sum(self : ChemdescmaccsTable) -> Double { @_common.sum(self.data) }

pub fn ChemdescmaccsTable::mean(self : ChemdescmaccsTable) -> Double { @_common.mean(self.data) }

pub fn ChemdescmaccsTable::scale(self : ChemdescmaccsTable, f : Double) -> ChemdescmaccsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsTable::add(self : ChemdescmaccsTable, other : ChemdescmaccsTable) -> ChemdescmaccsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescmaccsTable::copy(self : ChemdescmaccsTable) -> ChemdescmaccsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsTable::fill(self : ChemdescmaccsTable, v : Double) -> ChemdescmaccsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsTable::min(self : ChemdescmaccsTable) -> Double { @_common.min(self.data) }

pub fn ChemdescmaccsTable::max(self : ChemdescmaccsTable) -> Double { @_common.max(self.data) }

pub fn ChemdescmaccsTable::to_string(self : ChemdescmaccsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_graphn_make(size : Int) -> ChemdescmaccsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescmaccsGraphN::len(self : ChemdescmaccsGraphN) -> Int { self.size }

pub fn ChemdescmaccsGraphN::get(self : ChemdescmaccsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescmaccsGraphN::set(self : ChemdescmaccsGraphN, i : Int, v : Double) -> ChemdescmaccsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsGraphN::sum(self : ChemdescmaccsGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemdescmaccsGraphN::mean(self : ChemdescmaccsGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemdescmaccsGraphN::scale(self : ChemdescmaccsGraphN, f : Double) -> ChemdescmaccsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsGraphN::add(self : ChemdescmaccsGraphN, other : ChemdescmaccsGraphN) -> ChemdescmaccsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescmaccsGraphN::copy(self : ChemdescmaccsGraphN) -> ChemdescmaccsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsGraphN::fill(self : ChemdescmaccsGraphN, v : Double) -> ChemdescmaccsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsGraphN::min(self : ChemdescmaccsGraphN) -> Double { @_common.min(self.data) }

pub fn ChemdescmaccsGraphN::max(self : ChemdescmaccsGraphN) -> Double { @_common.max(self.data) }

pub fn ChemdescmaccsGraphN::to_string(self : ChemdescmaccsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_node_make(size : Int) -> ChemdescmaccsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescmaccsNode::len(self : ChemdescmaccsNode) -> Int { self.size }

pub fn ChemdescmaccsNode::get(self : ChemdescmaccsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescmaccsNode::set(self : ChemdescmaccsNode, i : Int, v : Double) -> ChemdescmaccsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsNode::sum(self : ChemdescmaccsNode) -> Double { @_common.sum(self.data) }

pub fn ChemdescmaccsNode::mean(self : ChemdescmaccsNode) -> Double { @_common.mean(self.data) }

pub fn ChemdescmaccsNode::scale(self : ChemdescmaccsNode, f : Double) -> ChemdescmaccsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsNode::add(self : ChemdescmaccsNode, other : ChemdescmaccsNode) -> ChemdescmaccsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescmaccsNode::copy(self : ChemdescmaccsNode) -> ChemdescmaccsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsNode::fill(self : ChemdescmaccsNode, v : Double) -> ChemdescmaccsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsNode::min(self : ChemdescmaccsNode) -> Double { @_common.min(self.data) }

pub fn ChemdescmaccsNode::max(self : ChemdescmaccsNode) -> Double { @_common.max(self.data) }

pub fn ChemdescmaccsNode::to_string(self : ChemdescmaccsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_edge_make(size : Int) -> ChemdescmaccsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescmaccsEdge::len(self : ChemdescmaccsEdge) -> Int { self.size }

pub fn ChemdescmaccsEdge::get(self : ChemdescmaccsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescmaccsEdge::set(self : ChemdescmaccsEdge, i : Int, v : Double) -> ChemdescmaccsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsEdge::sum(self : ChemdescmaccsEdge) -> Double { @_common.sum(self.data) }

pub fn ChemdescmaccsEdge::mean(self : ChemdescmaccsEdge) -> Double { @_common.mean(self.data) }

pub fn ChemdescmaccsEdge::scale(self : ChemdescmaccsEdge, f : Double) -> ChemdescmaccsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsEdge::add(self : ChemdescmaccsEdge, other : ChemdescmaccsEdge) -> ChemdescmaccsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescmaccsEdge::copy(self : ChemdescmaccsEdge) -> ChemdescmaccsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsEdge::fill(self : ChemdescmaccsEdge, v : Double) -> ChemdescmaccsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsEdge::min(self : ChemdescmaccsEdge) -> Double { @_common.min(self.data) }

pub fn ChemdescmaccsEdge::max(self : ChemdescmaccsEdge) -> Double { @_common.max(self.data) }

pub fn ChemdescmaccsEdge::to_string(self : ChemdescmaccsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_path_make(size : Int) -> ChemdescmaccsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescmaccsPath::len(self : ChemdescmaccsPath) -> Int { self.size }

pub fn ChemdescmaccsPath::get(self : ChemdescmaccsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescmaccsPath::set(self : ChemdescmaccsPath, i : Int, v : Double) -> ChemdescmaccsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsPath::sum(self : ChemdescmaccsPath) -> Double { @_common.sum(self.data) }

pub fn ChemdescmaccsPath::mean(self : ChemdescmaccsPath) -> Double { @_common.mean(self.data) }

pub fn ChemdescmaccsPath::scale(self : ChemdescmaccsPath, f : Double) -> ChemdescmaccsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsPath::add(self : ChemdescmaccsPath, other : ChemdescmaccsPath) -> ChemdescmaccsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescmaccsPath::copy(self : ChemdescmaccsPath) -> ChemdescmaccsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsPath::fill(self : ChemdescmaccsPath, v : Double) -> ChemdescmaccsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsPath::min(self : ChemdescmaccsPath) -> Double { @_common.min(self.data) }

pub fn ChemdescmaccsPath::max(self : ChemdescmaccsPath) -> Double { @_common.max(self.data) }

pub fn ChemdescmaccsPath::to_string(self : ChemdescmaccsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_cluster_make(size : Int) -> ChemdescmaccsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescmaccsCluster::len(self : ChemdescmaccsCluster) -> Int { self.size }

pub fn ChemdescmaccsCluster::get(self : ChemdescmaccsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescmaccsCluster::set(self : ChemdescmaccsCluster, i : Int, v : Double) -> ChemdescmaccsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsCluster::sum(self : ChemdescmaccsCluster) -> Double { @_common.sum(self.data) }

pub fn ChemdescmaccsCluster::mean(self : ChemdescmaccsCluster) -> Double { @_common.mean(self.data) }

pub fn ChemdescmaccsCluster::scale(self : ChemdescmaccsCluster, f : Double) -> ChemdescmaccsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsCluster::add(self : ChemdescmaccsCluster, other : ChemdescmaccsCluster) -> ChemdescmaccsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescmaccsCluster::copy(self : ChemdescmaccsCluster) -> ChemdescmaccsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsCluster::fill(self : ChemdescmaccsCluster, v : Double) -> ChemdescmaccsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsCluster::min(self : ChemdescmaccsCluster) -> Double { @_common.min(self.data) }

pub fn ChemdescmaccsCluster::max(self : ChemdescmaccsCluster) -> Double { @_common.max(self.data) }

pub fn ChemdescmaccsCluster::to_string(self : ChemdescmaccsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_model_make(size : Int) -> ChemdescmaccsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescmaccsModel::len(self : ChemdescmaccsModel) -> Int { self.size }

pub fn ChemdescmaccsModel::get(self : ChemdescmaccsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescmaccsModel::set(self : ChemdescmaccsModel, i : Int, v : Double) -> ChemdescmaccsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsModel::sum(self : ChemdescmaccsModel) -> Double { @_common.sum(self.data) }

pub fn ChemdescmaccsModel::mean(self : ChemdescmaccsModel) -> Double { @_common.mean(self.data) }

pub fn ChemdescmaccsModel::scale(self : ChemdescmaccsModel, f : Double) -> ChemdescmaccsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsModel::add(self : ChemdescmaccsModel, other : ChemdescmaccsModel) -> ChemdescmaccsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescmaccsModel::copy(self : ChemdescmaccsModel) -> ChemdescmaccsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsModel::fill(self : ChemdescmaccsModel, v : Double) -> ChemdescmaccsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsModel::min(self : ChemdescmaccsModel) -> Double { @_common.min(self.data) }

pub fn ChemdescmaccsModel::max(self : ChemdescmaccsModel) -> Double { @_common.max(self.data) }

pub fn ChemdescmaccsModel::to_string(self : ChemdescmaccsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_layer_make(size : Int) -> ChemdescmaccsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescmaccsLayer::len(self : ChemdescmaccsLayer) -> Int { self.size }

pub fn ChemdescmaccsLayer::get(self : ChemdescmaccsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescmaccsLayer::set(self : ChemdescmaccsLayer, i : Int, v : Double) -> ChemdescmaccsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsLayer::sum(self : ChemdescmaccsLayer) -> Double { @_common.sum(self.data) }

pub fn ChemdescmaccsLayer::mean(self : ChemdescmaccsLayer) -> Double { @_common.mean(self.data) }

pub fn ChemdescmaccsLayer::scale(self : ChemdescmaccsLayer, f : Double) -> ChemdescmaccsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsLayer::add(self : ChemdescmaccsLayer, other : ChemdescmaccsLayer) -> ChemdescmaccsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescmaccsLayer::copy(self : ChemdescmaccsLayer) -> ChemdescmaccsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsLayer::fill(self : ChemdescmaccsLayer, v : Double) -> ChemdescmaccsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsLayer::min(self : ChemdescmaccsLayer) -> Double { @_common.min(self.data) }

pub fn ChemdescmaccsLayer::max(self : ChemdescmaccsLayer) -> Double { @_common.max(self.data) }

pub fn ChemdescmaccsLayer::to_string(self : ChemdescmaccsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_buffer_make(size : Int) -> ChemdescmaccsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescmaccsBuffer::len(self : ChemdescmaccsBuffer) -> Int { self.size }

pub fn ChemdescmaccsBuffer::get(self : ChemdescmaccsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescmaccsBuffer::set(self : ChemdescmaccsBuffer, i : Int, v : Double) -> ChemdescmaccsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsBuffer::sum(self : ChemdescmaccsBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemdescmaccsBuffer::mean(self : ChemdescmaccsBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemdescmaccsBuffer::scale(self : ChemdescmaccsBuffer, f : Double) -> ChemdescmaccsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsBuffer::add(self : ChemdescmaccsBuffer, other : ChemdescmaccsBuffer) -> ChemdescmaccsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescmaccsBuffer::copy(self : ChemdescmaccsBuffer) -> ChemdescmaccsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsBuffer::fill(self : ChemdescmaccsBuffer, v : Double) -> ChemdescmaccsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsBuffer::min(self : ChemdescmaccsBuffer) -> Double { @_common.min(self.data) }

pub fn ChemdescmaccsBuffer::max(self : ChemdescmaccsBuffer) -> Double { @_common.max(self.data) }

pub fn ChemdescmaccsBuffer::to_string(self : ChemdescmaccsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_cursor_make(size : Int) -> ChemdescmaccsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescmaccsCursor::len(self : ChemdescmaccsCursor) -> Int { self.size }

pub fn ChemdescmaccsCursor::get(self : ChemdescmaccsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescmaccsCursor::set(self : ChemdescmaccsCursor, i : Int, v : Double) -> ChemdescmaccsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsCursor::sum(self : ChemdescmaccsCursor) -> Double { @_common.sum(self.data) }

pub fn ChemdescmaccsCursor::mean(self : ChemdescmaccsCursor) -> Double { @_common.mean(self.data) }

pub fn ChemdescmaccsCursor::scale(self : ChemdescmaccsCursor, f : Double) -> ChemdescmaccsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsCursor::add(self : ChemdescmaccsCursor, other : ChemdescmaccsCursor) -> ChemdescmaccsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescmaccsCursor::copy(self : ChemdescmaccsCursor) -> ChemdescmaccsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsCursor::fill(self : ChemdescmaccsCursor, v : Double) -> ChemdescmaccsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsCursor::min(self : ChemdescmaccsCursor) -> Double { @_common.min(self.data) }

pub fn ChemdescmaccsCursor::max(self : ChemdescmaccsCursor) -> Double { @_common.max(self.data) }

pub fn ChemdescmaccsCursor::to_string(self : ChemdescmaccsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_view_make(size : Int) -> ChemdescmaccsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescmaccsView::len(self : ChemdescmaccsView) -> Int { self.size }

pub fn ChemdescmaccsView::get(self : ChemdescmaccsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescmaccsView::set(self : ChemdescmaccsView, i : Int, v : Double) -> ChemdescmaccsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsView::sum(self : ChemdescmaccsView) -> Double { @_common.sum(self.data) }

pub fn ChemdescmaccsView::mean(self : ChemdescmaccsView) -> Double { @_common.mean(self.data) }

pub fn ChemdescmaccsView::scale(self : ChemdescmaccsView, f : Double) -> ChemdescmaccsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsView::add(self : ChemdescmaccsView, other : ChemdescmaccsView) -> ChemdescmaccsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescmaccsView::copy(self : ChemdescmaccsView) -> ChemdescmaccsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsView::fill(self : ChemdescmaccsView, v : Double) -> ChemdescmaccsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsView::min(self : ChemdescmaccsView) -> Double { @_common.min(self.data) }

pub fn ChemdescmaccsView::max(self : ChemdescmaccsView) -> Double { @_common.max(self.data) }

pub fn ChemdescmaccsView::to_string(self : ChemdescmaccsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_range_make(size : Int) -> ChemdescmaccsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescmaccsRange::len(self : ChemdescmaccsRange) -> Int { self.size }

pub fn ChemdescmaccsRange::get(self : ChemdescmaccsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescmaccsRange::set(self : ChemdescmaccsRange, i : Int, v : Double) -> ChemdescmaccsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsRange::sum(self : ChemdescmaccsRange) -> Double { @_common.sum(self.data) }

pub fn ChemdescmaccsRange::mean(self : ChemdescmaccsRange) -> Double { @_common.mean(self.data) }

pub fn ChemdescmaccsRange::scale(self : ChemdescmaccsRange, f : Double) -> ChemdescmaccsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsRange::add(self : ChemdescmaccsRange, other : ChemdescmaccsRange) -> ChemdescmaccsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescmaccsRange::copy(self : ChemdescmaccsRange) -> ChemdescmaccsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsRange::fill(self : ChemdescmaccsRange, v : Double) -> ChemdescmaccsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsRange::min(self : ChemdescmaccsRange) -> Double { @_common.min(self.data) }

pub fn ChemdescmaccsRange::max(self : ChemdescmaccsRange) -> Double { @_common.max(self.data) }

pub fn ChemdescmaccsRange::to_string(self : ChemdescmaccsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescmaccsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_maccs_slice_make(size : Int) -> ChemdescmaccsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescmaccsSlice::len(self : ChemdescmaccsSlice) -> Int { self.size }

pub fn ChemdescmaccsSlice::get(self : ChemdescmaccsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescmaccsSlice::set(self : ChemdescmaccsSlice, i : Int, v : Double) -> ChemdescmaccsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsSlice::sum(self : ChemdescmaccsSlice) -> Double { @_common.sum(self.data) }

pub fn ChemdescmaccsSlice::mean(self : ChemdescmaccsSlice) -> Double { @_common.mean(self.data) }

pub fn ChemdescmaccsSlice::scale(self : ChemdescmaccsSlice, f : Double) -> ChemdescmaccsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsSlice::add(self : ChemdescmaccsSlice, other : ChemdescmaccsSlice) -> ChemdescmaccsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescmaccsSlice::copy(self : ChemdescmaccsSlice) -> ChemdescmaccsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsSlice::fill(self : ChemdescmaccsSlice, v : Double) -> ChemdescmaccsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescmaccsSlice::min(self : ChemdescmaccsSlice) -> Double { @_common.min(self.data) }

pub fn ChemdescmaccsSlice::max(self : ChemdescmaccsSlice) -> Double { @_common.max(self.data) }

pub fn ChemdescmaccsSlice::to_string(self : ChemdescmaccsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

