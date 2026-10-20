///===
/// extcore/ds_hash_double

pub(all) struct DshashdoublePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_double_make_point(x : Double, y : Double) -> DshashdoublePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_double_make_point3(x : Double, y : Double, z : Double) -> DshashdoublePoint {
  { x, y, z, label: 0 }
}

pub fn DshashdoublePoint::x(self : DshashdoublePoint) -> Double { self.x }

pub fn DshashdoublePoint::y(self : DshashdoublePoint) -> Double { self.y }

pub fn DshashdoublePoint::z(self : DshashdoublePoint) -> Double { self.z }

pub fn DshashdoublePoint::label(self : DshashdoublePoint) -> Int { self.label }

pub fn DshashdoublePoint::dist(self : DshashdoublePoint, other : DshashdoublePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DshashdoublePoint::add(self : DshashdoublePoint, other : DshashdoublePoint) -> DshashdoublePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DshashdoublePoint::sub(self : DshashdoublePoint, other : DshashdoublePoint) -> DshashdoublePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DshashdoublePoint::scale(self : DshashdoublePoint, s : Double) -> DshashdoublePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DshashdoublePoint::dot(self : DshashdoublePoint, other : DshashdoublePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DshashdoublePoint::cross(self : DshashdoublePoint, other : DshashdoublePoint) -> DshashdoublePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DshashdoublePoint::norm(self : DshashdoublePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DshashdoublePoint::normalize(self : DshashdoublePoint) -> DshashdoublePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashdoublePoint::negate(self : DshashdoublePoint) -> DshashdoublePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DshashdoublePoint::mid(self : DshashdoublePoint, other : DshashdoublePoint) -> DshashdoublePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DshashdoublePoint::lerp(self : DshashdoublePoint, other : DshashdoublePoint, t : Double) -> DshashdoublePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DshashdoublePoint::to_string(self : DshashdoublePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DshashdoubleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_double_make_series(vals : Array[Double], name : String) -> DshashdoubleSeries {
  { vals, name, meta: 0 }
}

pub fn DshashdoubleSeries::len(self : DshashdoubleSeries) -> Int { self.vals.length() }

pub fn DshashdoubleSeries::sum(self : DshashdoubleSeries) -> Double { @_common.sum(self.vals) }

pub fn DshashdoubleSeries::mean(self : DshashdoubleSeries) -> Double { @_common.mean(self.vals) }

pub fn DshashdoubleSeries::min(self : DshashdoubleSeries) -> Double { @_common.min(self.vals) }

pub fn DshashdoubleSeries::max(self : DshashdoubleSeries) -> Double { @_common.max(self.vals) }

pub fn DshashdoubleSeries::range(self : DshashdoubleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DshashdoubleSeries::variance(self : DshashdoubleSeries) -> Double { @_common.variance(self.vals) }

pub fn DshashdoubleSeries::std(self : DshashdoubleSeries) -> Double { @_common.std(self.vals) }

pub fn DshashdoubleSeries::median(self : DshashdoubleSeries) -> Double { @_common.median(self.vals) }

pub fn DshashdoubleSeries::scale(self : DshashdoubleSeries, f : Double) -> DshashdoubleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DshashdoubleSeries::add(self : DshashdoubleSeries, other : DshashdoubleSeries) -> DshashdoubleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DshashdoubleSeries::sub(self : DshashdoubleSeries, other : DshashdoubleSeries) -> DshashdoubleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DshashdoubleSeries::normalize(self : DshashdoubleSeries) -> DshashdoubleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DshashdoubleSeries::cumsum(self : DshashdoubleSeries) -> DshashdoubleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DshashdoubleSeries::to_string(self : DshashdoubleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashdoubleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_double_make_matrix(rows : Int, cols : Int, val : Double) -> DshashdoubleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_double_matrix_identity(n : Int) -> DshashdoubleMatrix {
  let m = ds_hash_double_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DshashdoubleMatrix::get(self : DshashdoubleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DshashdoubleMatrix::transpose(self : DshashdoubleMatrix) -> DshashdoubleMatrix {
  let result = ds_hash_double_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DshashdoubleMatrix::add(self : DshashdoubleMatrix, other : DshashdoubleMatrix) -> DshashdoubleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_hash_double_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DshashdoubleMatrix::scale(self : DshashdoubleMatrix, s : Double) -> DshashdoubleMatrix {
  let result = ds_hash_double_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DshashdoubleMatrix::multiply(self : DshashdoubleMatrix, other : DshashdoubleMatrix) -> DshashdoubleMatrix {
  if self.cols != other.rows { return ds_hash_double_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_hash_double_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DshashdoubleMatrix::trace(self : DshashdoubleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DshashdoubleMatrix::det(self : DshashdoubleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DshashdoubleMatrix::norm(self : DshashdoubleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DshashdoubleMatrix::to_string(self : DshashdoubleMatrix) -> String {
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

pub(all) struct DshashdoubleVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_double_make_vector(comps : Array[Double]) -> DshashdoubleVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_double_vector_zero(dim : Int) -> DshashdoubleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DshashdoubleVector::add(self : DshashdoubleVector, other : DshashdoubleVector) -> DshashdoubleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DshashdoubleVector::sub(self : DshashdoubleVector, other : DshashdoubleVector) -> DshashdoubleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DshashdoubleVector::scale(self : DshashdoubleVector, s : Double) -> DshashdoubleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DshashdoubleVector::dot(self : DshashdoubleVector, other : DshashdoubleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DshashdoubleVector::norm(self : DshashdoubleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DshashdoubleVector::normalize(self : DshashdoubleVector) -> DshashdoubleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashdoubleVector::dist(self : DshashdoubleVector, other : DshashdoubleVector) -> Double {
  self.sub(other).norm()
}

pub fn DshashdoubleVector::to_string(self : DshashdoubleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashdoubleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_frame_make(size : Int) -> DshashdoubleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashdoubleFrame::len(self : DshashdoubleFrame) -> Int { self.size }

pub fn DshashdoubleFrame::get(self : DshashdoubleFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashdoubleFrame::set(self : DshashdoubleFrame, i : Int, v : Double) -> DshashdoubleFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashdoubleFrame::sum(self : DshashdoubleFrame) -> Double { @_common.sum(self.data) }

pub fn DshashdoubleFrame::mean(self : DshashdoubleFrame) -> Double { @_common.mean(self.data) }

pub fn DshashdoubleFrame::scale(self : DshashdoubleFrame, f : Double) -> DshashdoubleFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashdoubleFrame::add(self : DshashdoubleFrame, other : DshashdoubleFrame) -> DshashdoubleFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashdoubleFrame::copy(self : DshashdoubleFrame) -> DshashdoubleFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashdoubleFrame::fill(self : DshashdoubleFrame, v : Double) -> DshashdoubleFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashdoubleFrame::min(self : DshashdoubleFrame) -> Double { @_common.min(self.data) }

pub fn DshashdoubleFrame::max(self : DshashdoubleFrame) -> Double { @_common.max(self.data) }

pub fn DshashdoubleFrame::to_string(self : DshashdoubleFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashdoubleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_table_make(size : Int) -> DshashdoubleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashdoubleTable::len(self : DshashdoubleTable) -> Int { self.size }

pub fn DshashdoubleTable::get(self : DshashdoubleTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashdoubleTable::set(self : DshashdoubleTable, i : Int, v : Double) -> DshashdoubleTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashdoubleTable::sum(self : DshashdoubleTable) -> Double { @_common.sum(self.data) }

pub fn DshashdoubleTable::mean(self : DshashdoubleTable) -> Double { @_common.mean(self.data) }

pub fn DshashdoubleTable::scale(self : DshashdoubleTable, f : Double) -> DshashdoubleTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashdoubleTable::add(self : DshashdoubleTable, other : DshashdoubleTable) -> DshashdoubleTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashdoubleTable::copy(self : DshashdoubleTable) -> DshashdoubleTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashdoubleTable::fill(self : DshashdoubleTable, v : Double) -> DshashdoubleTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashdoubleTable::min(self : DshashdoubleTable) -> Double { @_common.min(self.data) }

pub fn DshashdoubleTable::max(self : DshashdoubleTable) -> Double { @_common.max(self.data) }

pub fn DshashdoubleTable::to_string(self : DshashdoubleTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashdoubleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_graphn_make(size : Int) -> DshashdoubleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashdoubleGraphN::len(self : DshashdoubleGraphN) -> Int { self.size }

pub fn DshashdoubleGraphN::get(self : DshashdoubleGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashdoubleGraphN::set(self : DshashdoubleGraphN, i : Int, v : Double) -> DshashdoubleGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashdoubleGraphN::sum(self : DshashdoubleGraphN) -> Double { @_common.sum(self.data) }

pub fn DshashdoubleGraphN::mean(self : DshashdoubleGraphN) -> Double { @_common.mean(self.data) }

pub fn DshashdoubleGraphN::scale(self : DshashdoubleGraphN, f : Double) -> DshashdoubleGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashdoubleGraphN::add(self : DshashdoubleGraphN, other : DshashdoubleGraphN) -> DshashdoubleGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashdoubleGraphN::copy(self : DshashdoubleGraphN) -> DshashdoubleGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashdoubleGraphN::fill(self : DshashdoubleGraphN, v : Double) -> DshashdoubleGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashdoubleGraphN::min(self : DshashdoubleGraphN) -> Double { @_common.min(self.data) }

pub fn DshashdoubleGraphN::max(self : DshashdoubleGraphN) -> Double { @_common.max(self.data) }

pub fn DshashdoubleGraphN::to_string(self : DshashdoubleGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashdoubleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_node_make(size : Int) -> DshashdoubleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashdoubleNode::len(self : DshashdoubleNode) -> Int { self.size }

pub fn DshashdoubleNode::get(self : DshashdoubleNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashdoubleNode::set(self : DshashdoubleNode, i : Int, v : Double) -> DshashdoubleNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashdoubleNode::sum(self : DshashdoubleNode) -> Double { @_common.sum(self.data) }

pub fn DshashdoubleNode::mean(self : DshashdoubleNode) -> Double { @_common.mean(self.data) }

pub fn DshashdoubleNode::scale(self : DshashdoubleNode, f : Double) -> DshashdoubleNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashdoubleNode::add(self : DshashdoubleNode, other : DshashdoubleNode) -> DshashdoubleNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashdoubleNode::copy(self : DshashdoubleNode) -> DshashdoubleNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashdoubleNode::fill(self : DshashdoubleNode, v : Double) -> DshashdoubleNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashdoubleNode::min(self : DshashdoubleNode) -> Double { @_common.min(self.data) }

pub fn DshashdoubleNode::max(self : DshashdoubleNode) -> Double { @_common.max(self.data) }

pub fn DshashdoubleNode::to_string(self : DshashdoubleNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashdoubleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_edge_make(size : Int) -> DshashdoubleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashdoubleEdge::len(self : DshashdoubleEdge) -> Int { self.size }

pub fn DshashdoubleEdge::get(self : DshashdoubleEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashdoubleEdge::set(self : DshashdoubleEdge, i : Int, v : Double) -> DshashdoubleEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashdoubleEdge::sum(self : DshashdoubleEdge) -> Double { @_common.sum(self.data) }

pub fn DshashdoubleEdge::mean(self : DshashdoubleEdge) -> Double { @_common.mean(self.data) }

pub fn DshashdoubleEdge::scale(self : DshashdoubleEdge, f : Double) -> DshashdoubleEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashdoubleEdge::add(self : DshashdoubleEdge, other : DshashdoubleEdge) -> DshashdoubleEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashdoubleEdge::copy(self : DshashdoubleEdge) -> DshashdoubleEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashdoubleEdge::fill(self : DshashdoubleEdge, v : Double) -> DshashdoubleEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashdoubleEdge::min(self : DshashdoubleEdge) -> Double { @_common.min(self.data) }

pub fn DshashdoubleEdge::max(self : DshashdoubleEdge) -> Double { @_common.max(self.data) }

pub fn DshashdoubleEdge::to_string(self : DshashdoubleEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashdoublePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_path_make(size : Int) -> DshashdoublePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashdoublePath::len(self : DshashdoublePath) -> Int { self.size }

pub fn DshashdoublePath::get(self : DshashdoublePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashdoublePath::set(self : DshashdoublePath, i : Int, v : Double) -> DshashdoublePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashdoublePath::sum(self : DshashdoublePath) -> Double { @_common.sum(self.data) }

pub fn DshashdoublePath::mean(self : DshashdoublePath) -> Double { @_common.mean(self.data) }

pub fn DshashdoublePath::scale(self : DshashdoublePath, f : Double) -> DshashdoublePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashdoublePath::add(self : DshashdoublePath, other : DshashdoublePath) -> DshashdoublePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashdoublePath::copy(self : DshashdoublePath) -> DshashdoublePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashdoublePath::fill(self : DshashdoublePath, v : Double) -> DshashdoublePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashdoublePath::min(self : DshashdoublePath) -> Double { @_common.min(self.data) }

pub fn DshashdoublePath::max(self : DshashdoublePath) -> Double { @_common.max(self.data) }

pub fn DshashdoublePath::to_string(self : DshashdoublePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashdoubleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_cluster_make(size : Int) -> DshashdoubleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashdoubleCluster::len(self : DshashdoubleCluster) -> Int { self.size }

pub fn DshashdoubleCluster::get(self : DshashdoubleCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashdoubleCluster::set(self : DshashdoubleCluster, i : Int, v : Double) -> DshashdoubleCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashdoubleCluster::sum(self : DshashdoubleCluster) -> Double { @_common.sum(self.data) }

pub fn DshashdoubleCluster::mean(self : DshashdoubleCluster) -> Double { @_common.mean(self.data) }

pub fn DshashdoubleCluster::scale(self : DshashdoubleCluster, f : Double) -> DshashdoubleCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashdoubleCluster::add(self : DshashdoubleCluster, other : DshashdoubleCluster) -> DshashdoubleCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashdoubleCluster::copy(self : DshashdoubleCluster) -> DshashdoubleCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashdoubleCluster::fill(self : DshashdoubleCluster, v : Double) -> DshashdoubleCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashdoubleCluster::min(self : DshashdoubleCluster) -> Double { @_common.min(self.data) }

pub fn DshashdoubleCluster::max(self : DshashdoubleCluster) -> Double { @_common.max(self.data) }

pub fn DshashdoubleCluster::to_string(self : DshashdoubleCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashdoubleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_model_make(size : Int) -> DshashdoubleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashdoubleModel::len(self : DshashdoubleModel) -> Int { self.size }

pub fn DshashdoubleModel::get(self : DshashdoubleModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashdoubleModel::set(self : DshashdoubleModel, i : Int, v : Double) -> DshashdoubleModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashdoubleModel::sum(self : DshashdoubleModel) -> Double { @_common.sum(self.data) }

pub fn DshashdoubleModel::mean(self : DshashdoubleModel) -> Double { @_common.mean(self.data) }

pub fn DshashdoubleModel::scale(self : DshashdoubleModel, f : Double) -> DshashdoubleModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashdoubleModel::add(self : DshashdoubleModel, other : DshashdoubleModel) -> DshashdoubleModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashdoubleModel::copy(self : DshashdoubleModel) -> DshashdoubleModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashdoubleModel::fill(self : DshashdoubleModel, v : Double) -> DshashdoubleModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashdoubleModel::min(self : DshashdoubleModel) -> Double { @_common.min(self.data) }

pub fn DshashdoubleModel::max(self : DshashdoubleModel) -> Double { @_common.max(self.data) }

pub fn DshashdoubleModel::to_string(self : DshashdoubleModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashdoubleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_layer_make(size : Int) -> DshashdoubleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashdoubleLayer::len(self : DshashdoubleLayer) -> Int { self.size }

pub fn DshashdoubleLayer::get(self : DshashdoubleLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashdoubleLayer::set(self : DshashdoubleLayer, i : Int, v : Double) -> DshashdoubleLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashdoubleLayer::sum(self : DshashdoubleLayer) -> Double { @_common.sum(self.data) }

pub fn DshashdoubleLayer::mean(self : DshashdoubleLayer) -> Double { @_common.mean(self.data) }

pub fn DshashdoubleLayer::scale(self : DshashdoubleLayer, f : Double) -> DshashdoubleLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashdoubleLayer::add(self : DshashdoubleLayer, other : DshashdoubleLayer) -> DshashdoubleLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashdoubleLayer::copy(self : DshashdoubleLayer) -> DshashdoubleLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashdoubleLayer::fill(self : DshashdoubleLayer, v : Double) -> DshashdoubleLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashdoubleLayer::min(self : DshashdoubleLayer) -> Double { @_common.min(self.data) }

pub fn DshashdoubleLayer::max(self : DshashdoubleLayer) -> Double { @_common.max(self.data) }

pub fn DshashdoubleLayer::to_string(self : DshashdoubleLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashdoubleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_buffer_make(size : Int) -> DshashdoubleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashdoubleBuffer::len(self : DshashdoubleBuffer) -> Int { self.size }

pub fn DshashdoubleBuffer::get(self : DshashdoubleBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashdoubleBuffer::set(self : DshashdoubleBuffer, i : Int, v : Double) -> DshashdoubleBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashdoubleBuffer::sum(self : DshashdoubleBuffer) -> Double { @_common.sum(self.data) }

pub fn DshashdoubleBuffer::mean(self : DshashdoubleBuffer) -> Double { @_common.mean(self.data) }

pub fn DshashdoubleBuffer::scale(self : DshashdoubleBuffer, f : Double) -> DshashdoubleBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashdoubleBuffer::add(self : DshashdoubleBuffer, other : DshashdoubleBuffer) -> DshashdoubleBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashdoubleBuffer::copy(self : DshashdoubleBuffer) -> DshashdoubleBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashdoubleBuffer::fill(self : DshashdoubleBuffer, v : Double) -> DshashdoubleBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashdoubleBuffer::min(self : DshashdoubleBuffer) -> Double { @_common.min(self.data) }

pub fn DshashdoubleBuffer::max(self : DshashdoubleBuffer) -> Double { @_common.max(self.data) }

pub fn DshashdoubleBuffer::to_string(self : DshashdoubleBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashdoubleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_cursor_make(size : Int) -> DshashdoubleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashdoubleCursor::len(self : DshashdoubleCursor) -> Int { self.size }

pub fn DshashdoubleCursor::get(self : DshashdoubleCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashdoubleCursor::set(self : DshashdoubleCursor, i : Int, v : Double) -> DshashdoubleCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashdoubleCursor::sum(self : DshashdoubleCursor) -> Double { @_common.sum(self.data) }

pub fn DshashdoubleCursor::mean(self : DshashdoubleCursor) -> Double { @_common.mean(self.data) }

pub fn DshashdoubleCursor::scale(self : DshashdoubleCursor, f : Double) -> DshashdoubleCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashdoubleCursor::add(self : DshashdoubleCursor, other : DshashdoubleCursor) -> DshashdoubleCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashdoubleCursor::copy(self : DshashdoubleCursor) -> DshashdoubleCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashdoubleCursor::fill(self : DshashdoubleCursor, v : Double) -> DshashdoubleCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashdoubleCursor::min(self : DshashdoubleCursor) -> Double { @_common.min(self.data) }

pub fn DshashdoubleCursor::max(self : DshashdoubleCursor) -> Double { @_common.max(self.data) }

pub fn DshashdoubleCursor::to_string(self : DshashdoubleCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashdoubleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_view_make(size : Int) -> DshashdoubleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashdoubleView::len(self : DshashdoubleView) -> Int { self.size }

pub fn DshashdoubleView::get(self : DshashdoubleView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashdoubleView::set(self : DshashdoubleView, i : Int, v : Double) -> DshashdoubleView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashdoubleView::sum(self : DshashdoubleView) -> Double { @_common.sum(self.data) }

pub fn DshashdoubleView::mean(self : DshashdoubleView) -> Double { @_common.mean(self.data) }

pub fn DshashdoubleView::scale(self : DshashdoubleView, f : Double) -> DshashdoubleView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashdoubleView::add(self : DshashdoubleView, other : DshashdoubleView) -> DshashdoubleView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashdoubleView::copy(self : DshashdoubleView) -> DshashdoubleView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashdoubleView::fill(self : DshashdoubleView, v : Double) -> DshashdoubleView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashdoubleView::min(self : DshashdoubleView) -> Double { @_common.min(self.data) }

pub fn DshashdoubleView::max(self : DshashdoubleView) -> Double { @_common.max(self.data) }

pub fn DshashdoubleView::to_string(self : DshashdoubleView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashdoubleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_range_make(size : Int) -> DshashdoubleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashdoubleRange::len(self : DshashdoubleRange) -> Int { self.size }

pub fn DshashdoubleRange::get(self : DshashdoubleRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashdoubleRange::set(self : DshashdoubleRange, i : Int, v : Double) -> DshashdoubleRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashdoubleRange::sum(self : DshashdoubleRange) -> Double { @_common.sum(self.data) }

pub fn DshashdoubleRange::mean(self : DshashdoubleRange) -> Double { @_common.mean(self.data) }

pub fn DshashdoubleRange::scale(self : DshashdoubleRange, f : Double) -> DshashdoubleRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashdoubleRange::add(self : DshashdoubleRange, other : DshashdoubleRange) -> DshashdoubleRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashdoubleRange::copy(self : DshashdoubleRange) -> DshashdoubleRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashdoubleRange::fill(self : DshashdoubleRange, v : Double) -> DshashdoubleRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashdoubleRange::min(self : DshashdoubleRange) -> Double { @_common.min(self.data) }

pub fn DshashdoubleRange::max(self : DshashdoubleRange) -> Double { @_common.max(self.data) }

pub fn DshashdoubleRange::to_string(self : DshashdoubleRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashdoubleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_slice_make(size : Int) -> DshashdoubleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashdoubleSlice::len(self : DshashdoubleSlice) -> Int { self.size }

pub fn DshashdoubleSlice::get(self : DshashdoubleSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashdoubleSlice::set(self : DshashdoubleSlice, i : Int, v : Double) -> DshashdoubleSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashdoubleSlice::sum(self : DshashdoubleSlice) -> Double { @_common.sum(self.data) }

pub fn DshashdoubleSlice::mean(self : DshashdoubleSlice) -> Double { @_common.mean(self.data) }

pub fn DshashdoubleSlice::scale(self : DshashdoubleSlice, f : Double) -> DshashdoubleSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashdoubleSlice::add(self : DshashdoubleSlice, other : DshashdoubleSlice) -> DshashdoubleSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashdoubleSlice::copy(self : DshashdoubleSlice) -> DshashdoubleSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashdoubleSlice::fill(self : DshashdoubleSlice, v : Double) -> DshashdoubleSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashdoubleSlice::min(self : DshashdoubleSlice) -> Double { @_common.min(self.data) }

pub fn DshashdoubleSlice::max(self : DshashdoubleSlice) -> Double { @_common.max(self.data) }

pub fn DshashdoubleSlice::to_string(self : DshashdoubleSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

