///===
/// extcore/ds_hash_quadratic

pub(all) struct DshashquadraticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_quadratic_make_point(x : Double, y : Double) -> DshashquadraticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_quadratic_make_point3(x : Double, y : Double, z : Double) -> DshashquadraticPoint {
  { x, y, z, label: 0 }
}

pub fn DshashquadraticPoint::x(self : DshashquadraticPoint) -> Double { self.x }

pub fn DshashquadraticPoint::y(self : DshashquadraticPoint) -> Double { self.y }

pub fn DshashquadraticPoint::z(self : DshashquadraticPoint) -> Double { self.z }

pub fn DshashquadraticPoint::label(self : DshashquadraticPoint) -> Int { self.label }

pub fn DshashquadraticPoint::dist(self : DshashquadraticPoint, other : DshashquadraticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DshashquadraticPoint::add(self : DshashquadraticPoint, other : DshashquadraticPoint) -> DshashquadraticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DshashquadraticPoint::sub(self : DshashquadraticPoint, other : DshashquadraticPoint) -> DshashquadraticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DshashquadraticPoint::scale(self : DshashquadraticPoint, s : Double) -> DshashquadraticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DshashquadraticPoint::dot(self : DshashquadraticPoint, other : DshashquadraticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DshashquadraticPoint::cross(self : DshashquadraticPoint, other : DshashquadraticPoint) -> DshashquadraticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DshashquadraticPoint::norm(self : DshashquadraticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DshashquadraticPoint::normalize(self : DshashquadraticPoint) -> DshashquadraticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashquadraticPoint::negate(self : DshashquadraticPoint) -> DshashquadraticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DshashquadraticPoint::mid(self : DshashquadraticPoint, other : DshashquadraticPoint) -> DshashquadraticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DshashquadraticPoint::lerp(self : DshashquadraticPoint, other : DshashquadraticPoint, t : Double) -> DshashquadraticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DshashquadraticPoint::to_string(self : DshashquadraticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DshashquadraticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_quadratic_make_series(vals : Array[Double], name : String) -> DshashquadraticSeries {
  { vals, name, meta: 0 }
}

pub fn DshashquadraticSeries::len(self : DshashquadraticSeries) -> Int { self.vals.length() }

pub fn DshashquadraticSeries::sum(self : DshashquadraticSeries) -> Double { @_common.sum(self.vals) }

pub fn DshashquadraticSeries::mean(self : DshashquadraticSeries) -> Double { @_common.mean(self.vals) }

pub fn DshashquadraticSeries::min(self : DshashquadraticSeries) -> Double { @_common.min(self.vals) }

pub fn DshashquadraticSeries::max(self : DshashquadraticSeries) -> Double { @_common.max(self.vals) }

pub fn DshashquadraticSeries::range(self : DshashquadraticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DshashquadraticSeries::variance(self : DshashquadraticSeries) -> Double { @_common.variance(self.vals) }

pub fn DshashquadraticSeries::std(self : DshashquadraticSeries) -> Double { @_common.std(self.vals) }

pub fn DshashquadraticSeries::median(self : DshashquadraticSeries) -> Double { @_common.median(self.vals) }

pub fn DshashquadraticSeries::scale(self : DshashquadraticSeries, f : Double) -> DshashquadraticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DshashquadraticSeries::add(self : DshashquadraticSeries, other : DshashquadraticSeries) -> DshashquadraticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DshashquadraticSeries::sub(self : DshashquadraticSeries, other : DshashquadraticSeries) -> DshashquadraticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DshashquadraticSeries::normalize(self : DshashquadraticSeries) -> DshashquadraticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DshashquadraticSeries::cumsum(self : DshashquadraticSeries) -> DshashquadraticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DshashquadraticSeries::to_string(self : DshashquadraticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashquadraticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_quadratic_make_matrix(rows : Int, cols : Int, val : Double) -> DshashquadraticMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ds_hash_quadratic_matrix_identity(n : Int) -> DshashquadraticMatrix {
  let m = ds_hash_quadratic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DshashquadraticMatrix::get(self : DshashquadraticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DshashquadraticMatrix::transpose(self : DshashquadraticMatrix) -> DshashquadraticMatrix {
  let result = ds_hash_quadratic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DshashquadraticMatrix::add(self : DshashquadraticMatrix, other : DshashquadraticMatrix) -> DshashquadraticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_hash_quadratic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DshashquadraticMatrix::scale(self : DshashquadraticMatrix, s : Double) -> DshashquadraticMatrix {
  let result = ds_hash_quadratic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DshashquadraticMatrix::multiply(self : DshashquadraticMatrix, other : DshashquadraticMatrix) -> DshashquadraticMatrix {
  if self.cols != other.rows { return ds_hash_quadratic_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_hash_quadratic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DshashquadraticMatrix::trace(self : DshashquadraticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DshashquadraticMatrix::det(self : DshashquadraticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DshashquadraticMatrix::norm(self : DshashquadraticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DshashquadraticMatrix::to_string(self : DshashquadraticMatrix) -> String {
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

pub(all) struct DshashquadraticVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_quadratic_make_vector(comps : Array[Double]) -> DshashquadraticVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_quadratic_vector_zero(dim : Int) -> DshashquadraticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DshashquadraticVector::add(self : DshashquadraticVector, other : DshashquadraticVector) -> DshashquadraticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DshashquadraticVector::sub(self : DshashquadraticVector, other : DshashquadraticVector) -> DshashquadraticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DshashquadraticVector::scale(self : DshashquadraticVector, s : Double) -> DshashquadraticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DshashquadraticVector::dot(self : DshashquadraticVector, other : DshashquadraticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DshashquadraticVector::norm(self : DshashquadraticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DshashquadraticVector::normalize(self : DshashquadraticVector) -> DshashquadraticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashquadraticVector::dist(self : DshashquadraticVector, other : DshashquadraticVector) -> Double {
  self.sub(other).norm()
}

pub fn DshashquadraticVector::to_string(self : DshashquadraticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashquadraticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_frame_make(size : Int) -> DshashquadraticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashquadraticFrame::len(self : DshashquadraticFrame) -> Int { self.size }

pub fn DshashquadraticFrame::get(self : DshashquadraticFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashquadraticFrame::set(self : DshashquadraticFrame, i : Int, v : Double) -> DshashquadraticFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashquadraticFrame::sum(self : DshashquadraticFrame) -> Double { @_common.sum(self.data) }

pub fn DshashquadraticFrame::mean(self : DshashquadraticFrame) -> Double { @_common.mean(self.data) }

pub fn DshashquadraticFrame::scale(self : DshashquadraticFrame, f : Double) -> DshashquadraticFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashquadraticFrame::add(self : DshashquadraticFrame, other : DshashquadraticFrame) -> DshashquadraticFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashquadraticFrame::copy(self : DshashquadraticFrame) -> DshashquadraticFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashquadraticFrame::fill(self : DshashquadraticFrame, v : Double) -> DshashquadraticFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashquadraticFrame::min(self : DshashquadraticFrame) -> Double { @_common.min(self.data) }

pub fn DshashquadraticFrame::max(self : DshashquadraticFrame) -> Double { @_common.max(self.data) }

pub fn DshashquadraticFrame::to_string(self : DshashquadraticFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashquadraticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_table_make(size : Int) -> DshashquadraticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashquadraticTable::len(self : DshashquadraticTable) -> Int { self.size }

pub fn DshashquadraticTable::get(self : DshashquadraticTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashquadraticTable::set(self : DshashquadraticTable, i : Int, v : Double) -> DshashquadraticTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashquadraticTable::sum(self : DshashquadraticTable) -> Double { @_common.sum(self.data) }

pub fn DshashquadraticTable::mean(self : DshashquadraticTable) -> Double { @_common.mean(self.data) }

pub fn DshashquadraticTable::scale(self : DshashquadraticTable, f : Double) -> DshashquadraticTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashquadraticTable::add(self : DshashquadraticTable, other : DshashquadraticTable) -> DshashquadraticTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashquadraticTable::copy(self : DshashquadraticTable) -> DshashquadraticTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashquadraticTable::fill(self : DshashquadraticTable, v : Double) -> DshashquadraticTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashquadraticTable::min(self : DshashquadraticTable) -> Double { @_common.min(self.data) }

pub fn DshashquadraticTable::max(self : DshashquadraticTable) -> Double { @_common.max(self.data) }

pub fn DshashquadraticTable::to_string(self : DshashquadraticTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashquadraticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_graphn_make(size : Int) -> DshashquadraticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashquadraticGraphN::len(self : DshashquadraticGraphN) -> Int { self.size }

pub fn DshashquadraticGraphN::get(self : DshashquadraticGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashquadraticGraphN::set(self : DshashquadraticGraphN, i : Int, v : Double) -> DshashquadraticGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashquadraticGraphN::sum(self : DshashquadraticGraphN) -> Double { @_common.sum(self.data) }

pub fn DshashquadraticGraphN::mean(self : DshashquadraticGraphN) -> Double { @_common.mean(self.data) }

pub fn DshashquadraticGraphN::scale(self : DshashquadraticGraphN, f : Double) -> DshashquadraticGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashquadraticGraphN::add(self : DshashquadraticGraphN, other : DshashquadraticGraphN) -> DshashquadraticGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashquadraticGraphN::copy(self : DshashquadraticGraphN) -> DshashquadraticGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashquadraticGraphN::fill(self : DshashquadraticGraphN, v : Double) -> DshashquadraticGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashquadraticGraphN::min(self : DshashquadraticGraphN) -> Double { @_common.min(self.data) }

pub fn DshashquadraticGraphN::max(self : DshashquadraticGraphN) -> Double { @_common.max(self.data) }

pub fn DshashquadraticGraphN::to_string(self : DshashquadraticGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashquadraticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_node_make(size : Int) -> DshashquadraticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashquadraticNode::len(self : DshashquadraticNode) -> Int { self.size }

pub fn DshashquadraticNode::get(self : DshashquadraticNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashquadraticNode::set(self : DshashquadraticNode, i : Int, v : Double) -> DshashquadraticNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashquadraticNode::sum(self : DshashquadraticNode) -> Double { @_common.sum(self.data) }

pub fn DshashquadraticNode::mean(self : DshashquadraticNode) -> Double { @_common.mean(self.data) }

pub fn DshashquadraticNode::scale(self : DshashquadraticNode, f : Double) -> DshashquadraticNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashquadraticNode::add(self : DshashquadraticNode, other : DshashquadraticNode) -> DshashquadraticNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashquadraticNode::copy(self : DshashquadraticNode) -> DshashquadraticNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashquadraticNode::fill(self : DshashquadraticNode, v : Double) -> DshashquadraticNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashquadraticNode::min(self : DshashquadraticNode) -> Double { @_common.min(self.data) }

pub fn DshashquadraticNode::max(self : DshashquadraticNode) -> Double { @_common.max(self.data) }

pub fn DshashquadraticNode::to_string(self : DshashquadraticNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashquadraticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_edge_make(size : Int) -> DshashquadraticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashquadraticEdge::len(self : DshashquadraticEdge) -> Int { self.size }

pub fn DshashquadraticEdge::get(self : DshashquadraticEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashquadraticEdge::set(self : DshashquadraticEdge, i : Int, v : Double) -> DshashquadraticEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashquadraticEdge::sum(self : DshashquadraticEdge) -> Double { @_common.sum(self.data) }

pub fn DshashquadraticEdge::mean(self : DshashquadraticEdge) -> Double { @_common.mean(self.data) }

pub fn DshashquadraticEdge::scale(self : DshashquadraticEdge, f : Double) -> DshashquadraticEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashquadraticEdge::add(self : DshashquadraticEdge, other : DshashquadraticEdge) -> DshashquadraticEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashquadraticEdge::copy(self : DshashquadraticEdge) -> DshashquadraticEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashquadraticEdge::fill(self : DshashquadraticEdge, v : Double) -> DshashquadraticEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashquadraticEdge::min(self : DshashquadraticEdge) -> Double { @_common.min(self.data) }

pub fn DshashquadraticEdge::max(self : DshashquadraticEdge) -> Double { @_common.max(self.data) }

pub fn DshashquadraticEdge::to_string(self : DshashquadraticEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashquadraticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_path_make(size : Int) -> DshashquadraticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashquadraticPath::len(self : DshashquadraticPath) -> Int { self.size }

pub fn DshashquadraticPath::get(self : DshashquadraticPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashquadraticPath::set(self : DshashquadraticPath, i : Int, v : Double) -> DshashquadraticPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashquadraticPath::sum(self : DshashquadraticPath) -> Double { @_common.sum(self.data) }

pub fn DshashquadraticPath::mean(self : DshashquadraticPath) -> Double { @_common.mean(self.data) }

pub fn DshashquadraticPath::scale(self : DshashquadraticPath, f : Double) -> DshashquadraticPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashquadraticPath::add(self : DshashquadraticPath, other : DshashquadraticPath) -> DshashquadraticPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashquadraticPath::copy(self : DshashquadraticPath) -> DshashquadraticPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashquadraticPath::fill(self : DshashquadraticPath, v : Double) -> DshashquadraticPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashquadraticPath::min(self : DshashquadraticPath) -> Double { @_common.min(self.data) }

pub fn DshashquadraticPath::max(self : DshashquadraticPath) -> Double { @_common.max(self.data) }

pub fn DshashquadraticPath::to_string(self : DshashquadraticPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashquadraticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_cluster_make(size : Int) -> DshashquadraticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashquadraticCluster::len(self : DshashquadraticCluster) -> Int { self.size }

pub fn DshashquadraticCluster::get(self : DshashquadraticCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashquadraticCluster::set(self : DshashquadraticCluster, i : Int, v : Double) -> DshashquadraticCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashquadraticCluster::sum(self : DshashquadraticCluster) -> Double { @_common.sum(self.data) }

pub fn DshashquadraticCluster::mean(self : DshashquadraticCluster) -> Double { @_common.mean(self.data) }

pub fn DshashquadraticCluster::scale(self : DshashquadraticCluster, f : Double) -> DshashquadraticCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashquadraticCluster::add(self : DshashquadraticCluster, other : DshashquadraticCluster) -> DshashquadraticCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashquadraticCluster::copy(self : DshashquadraticCluster) -> DshashquadraticCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashquadraticCluster::fill(self : DshashquadraticCluster, v : Double) -> DshashquadraticCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashquadraticCluster::min(self : DshashquadraticCluster) -> Double { @_common.min(self.data) }

pub fn DshashquadraticCluster::max(self : DshashquadraticCluster) -> Double { @_common.max(self.data) }

pub fn DshashquadraticCluster::to_string(self : DshashquadraticCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashquadraticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_model_make(size : Int) -> DshashquadraticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashquadraticModel::len(self : DshashquadraticModel) -> Int { self.size }

pub fn DshashquadraticModel::get(self : DshashquadraticModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashquadraticModel::set(self : DshashquadraticModel, i : Int, v : Double) -> DshashquadraticModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashquadraticModel::sum(self : DshashquadraticModel) -> Double { @_common.sum(self.data) }

pub fn DshashquadraticModel::mean(self : DshashquadraticModel) -> Double { @_common.mean(self.data) }

pub fn DshashquadraticModel::scale(self : DshashquadraticModel, f : Double) -> DshashquadraticModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashquadraticModel::add(self : DshashquadraticModel, other : DshashquadraticModel) -> DshashquadraticModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashquadraticModel::copy(self : DshashquadraticModel) -> DshashquadraticModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashquadraticModel::fill(self : DshashquadraticModel, v : Double) -> DshashquadraticModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashquadraticModel::min(self : DshashquadraticModel) -> Double { @_common.min(self.data) }

pub fn DshashquadraticModel::max(self : DshashquadraticModel) -> Double { @_common.max(self.data) }

pub fn DshashquadraticModel::to_string(self : DshashquadraticModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashquadraticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_layer_make(size : Int) -> DshashquadraticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashquadraticLayer::len(self : DshashquadraticLayer) -> Int { self.size }

pub fn DshashquadraticLayer::get(self : DshashquadraticLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashquadraticLayer::set(self : DshashquadraticLayer, i : Int, v : Double) -> DshashquadraticLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashquadraticLayer::sum(self : DshashquadraticLayer) -> Double { @_common.sum(self.data) }

pub fn DshashquadraticLayer::mean(self : DshashquadraticLayer) -> Double { @_common.mean(self.data) }

pub fn DshashquadraticLayer::scale(self : DshashquadraticLayer, f : Double) -> DshashquadraticLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashquadraticLayer::add(self : DshashquadraticLayer, other : DshashquadraticLayer) -> DshashquadraticLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashquadraticLayer::copy(self : DshashquadraticLayer) -> DshashquadraticLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashquadraticLayer::fill(self : DshashquadraticLayer, v : Double) -> DshashquadraticLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashquadraticLayer::min(self : DshashquadraticLayer) -> Double { @_common.min(self.data) }

pub fn DshashquadraticLayer::max(self : DshashquadraticLayer) -> Double { @_common.max(self.data) }

pub fn DshashquadraticLayer::to_string(self : DshashquadraticLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashquadraticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_buffer_make(size : Int) -> DshashquadraticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashquadraticBuffer::len(self : DshashquadraticBuffer) -> Int { self.size }

pub fn DshashquadraticBuffer::get(self : DshashquadraticBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashquadraticBuffer::set(self : DshashquadraticBuffer, i : Int, v : Double) -> DshashquadraticBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashquadraticBuffer::sum(self : DshashquadraticBuffer) -> Double { @_common.sum(self.data) }

pub fn DshashquadraticBuffer::mean(self : DshashquadraticBuffer) -> Double { @_common.mean(self.data) }

pub fn DshashquadraticBuffer::scale(self : DshashquadraticBuffer, f : Double) -> DshashquadraticBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashquadraticBuffer::add(self : DshashquadraticBuffer, other : DshashquadraticBuffer) -> DshashquadraticBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashquadraticBuffer::copy(self : DshashquadraticBuffer) -> DshashquadraticBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashquadraticBuffer::fill(self : DshashquadraticBuffer, v : Double) -> DshashquadraticBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashquadraticBuffer::min(self : DshashquadraticBuffer) -> Double { @_common.min(self.data) }

pub fn DshashquadraticBuffer::max(self : DshashquadraticBuffer) -> Double { @_common.max(self.data) }

pub fn DshashquadraticBuffer::to_string(self : DshashquadraticBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashquadraticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_cursor_make(size : Int) -> DshashquadraticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashquadraticCursor::len(self : DshashquadraticCursor) -> Int { self.size }

pub fn DshashquadraticCursor::get(self : DshashquadraticCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashquadraticCursor::set(self : DshashquadraticCursor, i : Int, v : Double) -> DshashquadraticCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashquadraticCursor::sum(self : DshashquadraticCursor) -> Double { @_common.sum(self.data) }

pub fn DshashquadraticCursor::mean(self : DshashquadraticCursor) -> Double { @_common.mean(self.data) }

pub fn DshashquadraticCursor::scale(self : DshashquadraticCursor, f : Double) -> DshashquadraticCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashquadraticCursor::add(self : DshashquadraticCursor, other : DshashquadraticCursor) -> DshashquadraticCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashquadraticCursor::copy(self : DshashquadraticCursor) -> DshashquadraticCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashquadraticCursor::fill(self : DshashquadraticCursor, v : Double) -> DshashquadraticCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashquadraticCursor::min(self : DshashquadraticCursor) -> Double { @_common.min(self.data) }

pub fn DshashquadraticCursor::max(self : DshashquadraticCursor) -> Double { @_common.max(self.data) }

pub fn DshashquadraticCursor::to_string(self : DshashquadraticCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashquadraticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_view_make(size : Int) -> DshashquadraticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashquadraticView::len(self : DshashquadraticView) -> Int { self.size }

pub fn DshashquadraticView::get(self : DshashquadraticView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashquadraticView::set(self : DshashquadraticView, i : Int, v : Double) -> DshashquadraticView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashquadraticView::sum(self : DshashquadraticView) -> Double { @_common.sum(self.data) }

pub fn DshashquadraticView::mean(self : DshashquadraticView) -> Double { @_common.mean(self.data) }

pub fn DshashquadraticView::scale(self : DshashquadraticView, f : Double) -> DshashquadraticView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashquadraticView::add(self : DshashquadraticView, other : DshashquadraticView) -> DshashquadraticView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashquadraticView::copy(self : DshashquadraticView) -> DshashquadraticView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashquadraticView::fill(self : DshashquadraticView, v : Double) -> DshashquadraticView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashquadraticView::min(self : DshashquadraticView) -> Double { @_common.min(self.data) }

pub fn DshashquadraticView::max(self : DshashquadraticView) -> Double { @_common.max(self.data) }

pub fn DshashquadraticView::to_string(self : DshashquadraticView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashquadraticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_range_make(size : Int) -> DshashquadraticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashquadraticRange::len(self : DshashquadraticRange) -> Int { self.size }

pub fn DshashquadraticRange::get(self : DshashquadraticRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashquadraticRange::set(self : DshashquadraticRange, i : Int, v : Double) -> DshashquadraticRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashquadraticRange::sum(self : DshashquadraticRange) -> Double { @_common.sum(self.data) }

pub fn DshashquadraticRange::mean(self : DshashquadraticRange) -> Double { @_common.mean(self.data) }

pub fn DshashquadraticRange::scale(self : DshashquadraticRange, f : Double) -> DshashquadraticRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashquadraticRange::add(self : DshashquadraticRange, other : DshashquadraticRange) -> DshashquadraticRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashquadraticRange::copy(self : DshashquadraticRange) -> DshashquadraticRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashquadraticRange::fill(self : DshashquadraticRange, v : Double) -> DshashquadraticRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashquadraticRange::min(self : DshashquadraticRange) -> Double { @_common.min(self.data) }

pub fn DshashquadraticRange::max(self : DshashquadraticRange) -> Double { @_common.max(self.data) }

pub fn DshashquadraticRange::to_string(self : DshashquadraticRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashquadraticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_quadratic_slice_make(size : Int) -> DshashquadraticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashquadraticSlice::len(self : DshashquadraticSlice) -> Int { self.size }

pub fn DshashquadraticSlice::get(self : DshashquadraticSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashquadraticSlice::set(self : DshashquadraticSlice, i : Int, v : Double) -> DshashquadraticSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashquadraticSlice::sum(self : DshashquadraticSlice) -> Double { @_common.sum(self.data) }

pub fn DshashquadraticSlice::mean(self : DshashquadraticSlice) -> Double { @_common.mean(self.data) }

pub fn DshashquadraticSlice::scale(self : DshashquadraticSlice, f : Double) -> DshashquadraticSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashquadraticSlice::add(self : DshashquadraticSlice, other : DshashquadraticSlice) -> DshashquadraticSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashquadraticSlice::copy(self : DshashquadraticSlice) -> DshashquadraticSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashquadraticSlice::fill(self : DshashquadraticSlice, v : Double) -> DshashquadraticSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashquadraticSlice::min(self : DshashquadraticSlice) -> Double { @_common.min(self.data) }

pub fn DshashquadraticSlice::max(self : DshashquadraticSlice) -> Double { @_common.max(self.data) }

pub fn DshashquadraticSlice::to_string(self : DshashquadraticSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

