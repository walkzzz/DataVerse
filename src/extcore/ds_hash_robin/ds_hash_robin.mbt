///===
/// extcore/ds_hash_robin

pub(all) struct DshashrobinPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_robin_make_point(x : Double, y : Double) -> DshashrobinPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_robin_make_point3(x : Double, y : Double, z : Double) -> DshashrobinPoint {
  { x, y, z, label: 0 }
}

pub fn DshashrobinPoint::x(self : DshashrobinPoint) -> Double { self.x }

pub fn DshashrobinPoint::y(self : DshashrobinPoint) -> Double { self.y }

pub fn DshashrobinPoint::z(self : DshashrobinPoint) -> Double { self.z }

pub fn DshashrobinPoint::label(self : DshashrobinPoint) -> Int { self.label }

pub fn DshashrobinPoint::dist(self : DshashrobinPoint, other : DshashrobinPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DshashrobinPoint::add(self : DshashrobinPoint, other : DshashrobinPoint) -> DshashrobinPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DshashrobinPoint::sub(self : DshashrobinPoint, other : DshashrobinPoint) -> DshashrobinPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DshashrobinPoint::scale(self : DshashrobinPoint, s : Double) -> DshashrobinPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DshashrobinPoint::dot(self : DshashrobinPoint, other : DshashrobinPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DshashrobinPoint::cross(self : DshashrobinPoint, other : DshashrobinPoint) -> DshashrobinPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DshashrobinPoint::norm(self : DshashrobinPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DshashrobinPoint::normalize(self : DshashrobinPoint) -> DshashrobinPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashrobinPoint::negate(self : DshashrobinPoint) -> DshashrobinPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DshashrobinPoint::mid(self : DshashrobinPoint, other : DshashrobinPoint) -> DshashrobinPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DshashrobinPoint::lerp(self : DshashrobinPoint, other : DshashrobinPoint, t : Double) -> DshashrobinPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DshashrobinPoint::to_string(self : DshashrobinPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DshashrobinSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_robin_make_series(vals : Array[Double], name : String) -> DshashrobinSeries {
  { vals, name, meta: 0 }
}

pub fn DshashrobinSeries::len(self : DshashrobinSeries) -> Int { self.vals.length() }

pub fn DshashrobinSeries::sum(self : DshashrobinSeries) -> Double { @_common.sum(self.vals) }

pub fn DshashrobinSeries::mean(self : DshashrobinSeries) -> Double { @_common.mean(self.vals) }

pub fn DshashrobinSeries::min(self : DshashrobinSeries) -> Double { @_common.min(self.vals) }

pub fn DshashrobinSeries::max(self : DshashrobinSeries) -> Double { @_common.max(self.vals) }

pub fn DshashrobinSeries::range(self : DshashrobinSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DshashrobinSeries::variance(self : DshashrobinSeries) -> Double { @_common.variance(self.vals) }

pub fn DshashrobinSeries::std(self : DshashrobinSeries) -> Double { @_common.std(self.vals) }

pub fn DshashrobinSeries::median(self : DshashrobinSeries) -> Double { @_common.median(self.vals) }

pub fn DshashrobinSeries::scale(self : DshashrobinSeries, f : Double) -> DshashrobinSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DshashrobinSeries::add(self : DshashrobinSeries, other : DshashrobinSeries) -> DshashrobinSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DshashrobinSeries::sub(self : DshashrobinSeries, other : DshashrobinSeries) -> DshashrobinSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DshashrobinSeries::normalize(self : DshashrobinSeries) -> DshashrobinSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DshashrobinSeries::cumsum(self : DshashrobinSeries) -> DshashrobinSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DshashrobinSeries::to_string(self : DshashrobinSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashrobinMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_robin_make_matrix(rows : Int, cols : Int, val : Double) -> DshashrobinMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ds_hash_robin_matrix_identity(n : Int) -> DshashrobinMatrix {
  let m = ds_hash_robin_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DshashrobinMatrix::get(self : DshashrobinMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DshashrobinMatrix::transpose(self : DshashrobinMatrix) -> DshashrobinMatrix {
  let result = ds_hash_robin_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DshashrobinMatrix::add(self : DshashrobinMatrix, other : DshashrobinMatrix) -> DshashrobinMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_hash_robin_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DshashrobinMatrix::scale(self : DshashrobinMatrix, s : Double) -> DshashrobinMatrix {
  let result = ds_hash_robin_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DshashrobinMatrix::multiply(self : DshashrobinMatrix, other : DshashrobinMatrix) -> DshashrobinMatrix {
  if self.cols != other.rows { return ds_hash_robin_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_hash_robin_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DshashrobinMatrix::trace(self : DshashrobinMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DshashrobinMatrix::det(self : DshashrobinMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DshashrobinMatrix::norm(self : DshashrobinMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DshashrobinMatrix::to_string(self : DshashrobinMatrix) -> String {
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

pub(all) struct DshashrobinVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_robin_make_vector(comps : Array[Double]) -> DshashrobinVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_robin_vector_zero(dim : Int) -> DshashrobinVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DshashrobinVector::add(self : DshashrobinVector, other : DshashrobinVector) -> DshashrobinVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DshashrobinVector::sub(self : DshashrobinVector, other : DshashrobinVector) -> DshashrobinVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DshashrobinVector::scale(self : DshashrobinVector, s : Double) -> DshashrobinVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DshashrobinVector::dot(self : DshashrobinVector, other : DshashrobinVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DshashrobinVector::norm(self : DshashrobinVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DshashrobinVector::normalize(self : DshashrobinVector) -> DshashrobinVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashrobinVector::dist(self : DshashrobinVector, other : DshashrobinVector) -> Double {
  self.sub(other).norm()
}

pub fn DshashrobinVector::to_string(self : DshashrobinVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashrobinFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_frame_make(size : Int) -> DshashrobinFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashrobinFrame::len(self : DshashrobinFrame) -> Int { self.size }

pub fn DshashrobinFrame::get(self : DshashrobinFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashrobinFrame::set(self : DshashrobinFrame, i : Int, v : Double) -> DshashrobinFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashrobinFrame::sum(self : DshashrobinFrame) -> Double { @_common.sum(self.data) }

pub fn DshashrobinFrame::mean(self : DshashrobinFrame) -> Double { @_common.mean(self.data) }

pub fn DshashrobinFrame::scale(self : DshashrobinFrame, f : Double) -> DshashrobinFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashrobinFrame::add(self : DshashrobinFrame, other : DshashrobinFrame) -> DshashrobinFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashrobinFrame::copy(self : DshashrobinFrame) -> DshashrobinFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashrobinFrame::fill(self : DshashrobinFrame, v : Double) -> DshashrobinFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashrobinFrame::min(self : DshashrobinFrame) -> Double { @_common.min(self.data) }

pub fn DshashrobinFrame::max(self : DshashrobinFrame) -> Double { @_common.max(self.data) }

pub fn DshashrobinFrame::to_string(self : DshashrobinFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashrobinTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_table_make(size : Int) -> DshashrobinTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashrobinTable::len(self : DshashrobinTable) -> Int { self.size }

pub fn DshashrobinTable::get(self : DshashrobinTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashrobinTable::set(self : DshashrobinTable, i : Int, v : Double) -> DshashrobinTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashrobinTable::sum(self : DshashrobinTable) -> Double { @_common.sum(self.data) }

pub fn DshashrobinTable::mean(self : DshashrobinTable) -> Double { @_common.mean(self.data) }

pub fn DshashrobinTable::scale(self : DshashrobinTable, f : Double) -> DshashrobinTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashrobinTable::add(self : DshashrobinTable, other : DshashrobinTable) -> DshashrobinTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashrobinTable::copy(self : DshashrobinTable) -> DshashrobinTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashrobinTable::fill(self : DshashrobinTable, v : Double) -> DshashrobinTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashrobinTable::min(self : DshashrobinTable) -> Double { @_common.min(self.data) }

pub fn DshashrobinTable::max(self : DshashrobinTable) -> Double { @_common.max(self.data) }

pub fn DshashrobinTable::to_string(self : DshashrobinTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashrobinGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_graphn_make(size : Int) -> DshashrobinGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashrobinGraphN::len(self : DshashrobinGraphN) -> Int { self.size }

pub fn DshashrobinGraphN::get(self : DshashrobinGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashrobinGraphN::set(self : DshashrobinGraphN, i : Int, v : Double) -> DshashrobinGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashrobinGraphN::sum(self : DshashrobinGraphN) -> Double { @_common.sum(self.data) }

pub fn DshashrobinGraphN::mean(self : DshashrobinGraphN) -> Double { @_common.mean(self.data) }

pub fn DshashrobinGraphN::scale(self : DshashrobinGraphN, f : Double) -> DshashrobinGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashrobinGraphN::add(self : DshashrobinGraphN, other : DshashrobinGraphN) -> DshashrobinGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashrobinGraphN::copy(self : DshashrobinGraphN) -> DshashrobinGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashrobinGraphN::fill(self : DshashrobinGraphN, v : Double) -> DshashrobinGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashrobinGraphN::min(self : DshashrobinGraphN) -> Double { @_common.min(self.data) }

pub fn DshashrobinGraphN::max(self : DshashrobinGraphN) -> Double { @_common.max(self.data) }

pub fn DshashrobinGraphN::to_string(self : DshashrobinGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashrobinNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_node_make(size : Int) -> DshashrobinNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashrobinNode::len(self : DshashrobinNode) -> Int { self.size }

pub fn DshashrobinNode::get(self : DshashrobinNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashrobinNode::set(self : DshashrobinNode, i : Int, v : Double) -> DshashrobinNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashrobinNode::sum(self : DshashrobinNode) -> Double { @_common.sum(self.data) }

pub fn DshashrobinNode::mean(self : DshashrobinNode) -> Double { @_common.mean(self.data) }

pub fn DshashrobinNode::scale(self : DshashrobinNode, f : Double) -> DshashrobinNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashrobinNode::add(self : DshashrobinNode, other : DshashrobinNode) -> DshashrobinNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashrobinNode::copy(self : DshashrobinNode) -> DshashrobinNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashrobinNode::fill(self : DshashrobinNode, v : Double) -> DshashrobinNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashrobinNode::min(self : DshashrobinNode) -> Double { @_common.min(self.data) }

pub fn DshashrobinNode::max(self : DshashrobinNode) -> Double { @_common.max(self.data) }

pub fn DshashrobinNode::to_string(self : DshashrobinNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashrobinEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_edge_make(size : Int) -> DshashrobinEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashrobinEdge::len(self : DshashrobinEdge) -> Int { self.size }

pub fn DshashrobinEdge::get(self : DshashrobinEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashrobinEdge::set(self : DshashrobinEdge, i : Int, v : Double) -> DshashrobinEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashrobinEdge::sum(self : DshashrobinEdge) -> Double { @_common.sum(self.data) }

pub fn DshashrobinEdge::mean(self : DshashrobinEdge) -> Double { @_common.mean(self.data) }

pub fn DshashrobinEdge::scale(self : DshashrobinEdge, f : Double) -> DshashrobinEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashrobinEdge::add(self : DshashrobinEdge, other : DshashrobinEdge) -> DshashrobinEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashrobinEdge::copy(self : DshashrobinEdge) -> DshashrobinEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashrobinEdge::fill(self : DshashrobinEdge, v : Double) -> DshashrobinEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashrobinEdge::min(self : DshashrobinEdge) -> Double { @_common.min(self.data) }

pub fn DshashrobinEdge::max(self : DshashrobinEdge) -> Double { @_common.max(self.data) }

pub fn DshashrobinEdge::to_string(self : DshashrobinEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashrobinPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_path_make(size : Int) -> DshashrobinPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashrobinPath::len(self : DshashrobinPath) -> Int { self.size }

pub fn DshashrobinPath::get(self : DshashrobinPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashrobinPath::set(self : DshashrobinPath, i : Int, v : Double) -> DshashrobinPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashrobinPath::sum(self : DshashrobinPath) -> Double { @_common.sum(self.data) }

pub fn DshashrobinPath::mean(self : DshashrobinPath) -> Double { @_common.mean(self.data) }

pub fn DshashrobinPath::scale(self : DshashrobinPath, f : Double) -> DshashrobinPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashrobinPath::add(self : DshashrobinPath, other : DshashrobinPath) -> DshashrobinPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashrobinPath::copy(self : DshashrobinPath) -> DshashrobinPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashrobinPath::fill(self : DshashrobinPath, v : Double) -> DshashrobinPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashrobinPath::min(self : DshashrobinPath) -> Double { @_common.min(self.data) }

pub fn DshashrobinPath::max(self : DshashrobinPath) -> Double { @_common.max(self.data) }

pub fn DshashrobinPath::to_string(self : DshashrobinPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashrobinCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_cluster_make(size : Int) -> DshashrobinCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashrobinCluster::len(self : DshashrobinCluster) -> Int { self.size }

pub fn DshashrobinCluster::get(self : DshashrobinCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashrobinCluster::set(self : DshashrobinCluster, i : Int, v : Double) -> DshashrobinCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashrobinCluster::sum(self : DshashrobinCluster) -> Double { @_common.sum(self.data) }

pub fn DshashrobinCluster::mean(self : DshashrobinCluster) -> Double { @_common.mean(self.data) }

pub fn DshashrobinCluster::scale(self : DshashrobinCluster, f : Double) -> DshashrobinCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashrobinCluster::add(self : DshashrobinCluster, other : DshashrobinCluster) -> DshashrobinCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashrobinCluster::copy(self : DshashrobinCluster) -> DshashrobinCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashrobinCluster::fill(self : DshashrobinCluster, v : Double) -> DshashrobinCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashrobinCluster::min(self : DshashrobinCluster) -> Double { @_common.min(self.data) }

pub fn DshashrobinCluster::max(self : DshashrobinCluster) -> Double { @_common.max(self.data) }

pub fn DshashrobinCluster::to_string(self : DshashrobinCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashrobinModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_model_make(size : Int) -> DshashrobinModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashrobinModel::len(self : DshashrobinModel) -> Int { self.size }

pub fn DshashrobinModel::get(self : DshashrobinModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashrobinModel::set(self : DshashrobinModel, i : Int, v : Double) -> DshashrobinModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashrobinModel::sum(self : DshashrobinModel) -> Double { @_common.sum(self.data) }

pub fn DshashrobinModel::mean(self : DshashrobinModel) -> Double { @_common.mean(self.data) }

pub fn DshashrobinModel::scale(self : DshashrobinModel, f : Double) -> DshashrobinModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashrobinModel::add(self : DshashrobinModel, other : DshashrobinModel) -> DshashrobinModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashrobinModel::copy(self : DshashrobinModel) -> DshashrobinModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashrobinModel::fill(self : DshashrobinModel, v : Double) -> DshashrobinModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashrobinModel::min(self : DshashrobinModel) -> Double { @_common.min(self.data) }

pub fn DshashrobinModel::max(self : DshashrobinModel) -> Double { @_common.max(self.data) }

pub fn DshashrobinModel::to_string(self : DshashrobinModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashrobinLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_layer_make(size : Int) -> DshashrobinLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashrobinLayer::len(self : DshashrobinLayer) -> Int { self.size }

pub fn DshashrobinLayer::get(self : DshashrobinLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashrobinLayer::set(self : DshashrobinLayer, i : Int, v : Double) -> DshashrobinLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashrobinLayer::sum(self : DshashrobinLayer) -> Double { @_common.sum(self.data) }

pub fn DshashrobinLayer::mean(self : DshashrobinLayer) -> Double { @_common.mean(self.data) }

pub fn DshashrobinLayer::scale(self : DshashrobinLayer, f : Double) -> DshashrobinLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashrobinLayer::add(self : DshashrobinLayer, other : DshashrobinLayer) -> DshashrobinLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashrobinLayer::copy(self : DshashrobinLayer) -> DshashrobinLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashrobinLayer::fill(self : DshashrobinLayer, v : Double) -> DshashrobinLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashrobinLayer::min(self : DshashrobinLayer) -> Double { @_common.min(self.data) }

pub fn DshashrobinLayer::max(self : DshashrobinLayer) -> Double { @_common.max(self.data) }

pub fn DshashrobinLayer::to_string(self : DshashrobinLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashrobinBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_buffer_make(size : Int) -> DshashrobinBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashrobinBuffer::len(self : DshashrobinBuffer) -> Int { self.size }

pub fn DshashrobinBuffer::get(self : DshashrobinBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashrobinBuffer::set(self : DshashrobinBuffer, i : Int, v : Double) -> DshashrobinBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashrobinBuffer::sum(self : DshashrobinBuffer) -> Double { @_common.sum(self.data) }

pub fn DshashrobinBuffer::mean(self : DshashrobinBuffer) -> Double { @_common.mean(self.data) }

pub fn DshashrobinBuffer::scale(self : DshashrobinBuffer, f : Double) -> DshashrobinBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashrobinBuffer::add(self : DshashrobinBuffer, other : DshashrobinBuffer) -> DshashrobinBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashrobinBuffer::copy(self : DshashrobinBuffer) -> DshashrobinBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashrobinBuffer::fill(self : DshashrobinBuffer, v : Double) -> DshashrobinBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashrobinBuffer::min(self : DshashrobinBuffer) -> Double { @_common.min(self.data) }

pub fn DshashrobinBuffer::max(self : DshashrobinBuffer) -> Double { @_common.max(self.data) }

pub fn DshashrobinBuffer::to_string(self : DshashrobinBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashrobinCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_cursor_make(size : Int) -> DshashrobinCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashrobinCursor::len(self : DshashrobinCursor) -> Int { self.size }

pub fn DshashrobinCursor::get(self : DshashrobinCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashrobinCursor::set(self : DshashrobinCursor, i : Int, v : Double) -> DshashrobinCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashrobinCursor::sum(self : DshashrobinCursor) -> Double { @_common.sum(self.data) }

pub fn DshashrobinCursor::mean(self : DshashrobinCursor) -> Double { @_common.mean(self.data) }

pub fn DshashrobinCursor::scale(self : DshashrobinCursor, f : Double) -> DshashrobinCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashrobinCursor::add(self : DshashrobinCursor, other : DshashrobinCursor) -> DshashrobinCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashrobinCursor::copy(self : DshashrobinCursor) -> DshashrobinCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashrobinCursor::fill(self : DshashrobinCursor, v : Double) -> DshashrobinCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashrobinCursor::min(self : DshashrobinCursor) -> Double { @_common.min(self.data) }

pub fn DshashrobinCursor::max(self : DshashrobinCursor) -> Double { @_common.max(self.data) }

pub fn DshashrobinCursor::to_string(self : DshashrobinCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashrobinView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_view_make(size : Int) -> DshashrobinView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashrobinView::len(self : DshashrobinView) -> Int { self.size }

pub fn DshashrobinView::get(self : DshashrobinView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashrobinView::set(self : DshashrobinView, i : Int, v : Double) -> DshashrobinView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashrobinView::sum(self : DshashrobinView) -> Double { @_common.sum(self.data) }

pub fn DshashrobinView::mean(self : DshashrobinView) -> Double { @_common.mean(self.data) }

pub fn DshashrobinView::scale(self : DshashrobinView, f : Double) -> DshashrobinView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashrobinView::add(self : DshashrobinView, other : DshashrobinView) -> DshashrobinView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashrobinView::copy(self : DshashrobinView) -> DshashrobinView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashrobinView::fill(self : DshashrobinView, v : Double) -> DshashrobinView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashrobinView::min(self : DshashrobinView) -> Double { @_common.min(self.data) }

pub fn DshashrobinView::max(self : DshashrobinView) -> Double { @_common.max(self.data) }

pub fn DshashrobinView::to_string(self : DshashrobinView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashrobinRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_range_make(size : Int) -> DshashrobinRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashrobinRange::len(self : DshashrobinRange) -> Int { self.size }

pub fn DshashrobinRange::get(self : DshashrobinRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashrobinRange::set(self : DshashrobinRange, i : Int, v : Double) -> DshashrobinRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashrobinRange::sum(self : DshashrobinRange) -> Double { @_common.sum(self.data) }

pub fn DshashrobinRange::mean(self : DshashrobinRange) -> Double { @_common.mean(self.data) }

pub fn DshashrobinRange::scale(self : DshashrobinRange, f : Double) -> DshashrobinRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashrobinRange::add(self : DshashrobinRange, other : DshashrobinRange) -> DshashrobinRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashrobinRange::copy(self : DshashrobinRange) -> DshashrobinRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashrobinRange::fill(self : DshashrobinRange, v : Double) -> DshashrobinRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashrobinRange::min(self : DshashrobinRange) -> Double { @_common.min(self.data) }

pub fn DshashrobinRange::max(self : DshashrobinRange) -> Double { @_common.max(self.data) }

pub fn DshashrobinRange::to_string(self : DshashrobinRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashrobinSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_slice_make(size : Int) -> DshashrobinSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashrobinSlice::len(self : DshashrobinSlice) -> Int { self.size }

pub fn DshashrobinSlice::get(self : DshashrobinSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashrobinSlice::set(self : DshashrobinSlice, i : Int, v : Double) -> DshashrobinSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashrobinSlice::sum(self : DshashrobinSlice) -> Double { @_common.sum(self.data) }

pub fn DshashrobinSlice::mean(self : DshashrobinSlice) -> Double { @_common.mean(self.data) }

pub fn DshashrobinSlice::scale(self : DshashrobinSlice, f : Double) -> DshashrobinSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashrobinSlice::add(self : DshashrobinSlice, other : DshashrobinSlice) -> DshashrobinSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashrobinSlice::copy(self : DshashrobinSlice) -> DshashrobinSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashrobinSlice::fill(self : DshashrobinSlice, v : Double) -> DshashrobinSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashrobinSlice::min(self : DshashrobinSlice) -> Double { @_common.min(self.data) }

pub fn DshashrobinSlice::max(self : DshashrobinSlice) -> Double { @_common.max(self.data) }

pub fn DshashrobinSlice::to_string(self : DshashrobinSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

