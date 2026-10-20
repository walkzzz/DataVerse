///===
/// extcore/ds_hash_cuckoo

pub(all) struct DshashcuckooPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_cuckoo_make_point(x : Double, y : Double) -> DshashcuckooPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_cuckoo_make_point3(x : Double, y : Double, z : Double) -> DshashcuckooPoint {
  { x, y, z, label: 0 }
}

pub fn DshashcuckooPoint::x(self : DshashcuckooPoint) -> Double { self.x }

pub fn DshashcuckooPoint::y(self : DshashcuckooPoint) -> Double { self.y }

pub fn DshashcuckooPoint::z(self : DshashcuckooPoint) -> Double { self.z }

pub fn DshashcuckooPoint::label(self : DshashcuckooPoint) -> Int { self.label }

pub fn DshashcuckooPoint::dist(self : DshashcuckooPoint, other : DshashcuckooPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DshashcuckooPoint::add(self : DshashcuckooPoint, other : DshashcuckooPoint) -> DshashcuckooPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DshashcuckooPoint::sub(self : DshashcuckooPoint, other : DshashcuckooPoint) -> DshashcuckooPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DshashcuckooPoint::scale(self : DshashcuckooPoint, s : Double) -> DshashcuckooPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DshashcuckooPoint::dot(self : DshashcuckooPoint, other : DshashcuckooPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DshashcuckooPoint::cross(self : DshashcuckooPoint, other : DshashcuckooPoint) -> DshashcuckooPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DshashcuckooPoint::norm(self : DshashcuckooPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DshashcuckooPoint::normalize(self : DshashcuckooPoint) -> DshashcuckooPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashcuckooPoint::negate(self : DshashcuckooPoint) -> DshashcuckooPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DshashcuckooPoint::mid(self : DshashcuckooPoint, other : DshashcuckooPoint) -> DshashcuckooPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DshashcuckooPoint::lerp(self : DshashcuckooPoint, other : DshashcuckooPoint, t : Double) -> DshashcuckooPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DshashcuckooPoint::to_string(self : DshashcuckooPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DshashcuckooSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_cuckoo_make_series(vals : Array[Double], name : String) -> DshashcuckooSeries {
  { vals, name, meta: 0 }
}

pub fn DshashcuckooSeries::len(self : DshashcuckooSeries) -> Int { self.vals.length() }

pub fn DshashcuckooSeries::sum(self : DshashcuckooSeries) -> Double { @_common.sum(self.vals) }

pub fn DshashcuckooSeries::mean(self : DshashcuckooSeries) -> Double { @_common.mean(self.vals) }

pub fn DshashcuckooSeries::min(self : DshashcuckooSeries) -> Double { @_common.min(self.vals) }

pub fn DshashcuckooSeries::max(self : DshashcuckooSeries) -> Double { @_common.max(self.vals) }

pub fn DshashcuckooSeries::range(self : DshashcuckooSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DshashcuckooSeries::variance(self : DshashcuckooSeries) -> Double { @_common.variance(self.vals) }

pub fn DshashcuckooSeries::std(self : DshashcuckooSeries) -> Double { @_common.std(self.vals) }

pub fn DshashcuckooSeries::median(self : DshashcuckooSeries) -> Double { @_common.median(self.vals) }

pub fn DshashcuckooSeries::scale(self : DshashcuckooSeries, f : Double) -> DshashcuckooSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DshashcuckooSeries::add(self : DshashcuckooSeries, other : DshashcuckooSeries) -> DshashcuckooSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DshashcuckooSeries::sub(self : DshashcuckooSeries, other : DshashcuckooSeries) -> DshashcuckooSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DshashcuckooSeries::normalize(self : DshashcuckooSeries) -> DshashcuckooSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DshashcuckooSeries::cumsum(self : DshashcuckooSeries) -> DshashcuckooSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DshashcuckooSeries::to_string(self : DshashcuckooSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashcuckooMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_cuckoo_make_matrix(rows : Int, cols : Int, val : Double) -> DshashcuckooMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ds_hash_cuckoo_matrix_identity(n : Int) -> DshashcuckooMatrix {
  let m = ds_hash_cuckoo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DshashcuckooMatrix::get(self : DshashcuckooMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DshashcuckooMatrix::transpose(self : DshashcuckooMatrix) -> DshashcuckooMatrix {
  let result = ds_hash_cuckoo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DshashcuckooMatrix::add(self : DshashcuckooMatrix, other : DshashcuckooMatrix) -> DshashcuckooMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_hash_cuckoo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DshashcuckooMatrix::scale(self : DshashcuckooMatrix, s : Double) -> DshashcuckooMatrix {
  let result = ds_hash_cuckoo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DshashcuckooMatrix::multiply(self : DshashcuckooMatrix, other : DshashcuckooMatrix) -> DshashcuckooMatrix {
  if self.cols != other.rows { return ds_hash_cuckoo_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_hash_cuckoo_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DshashcuckooMatrix::trace(self : DshashcuckooMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DshashcuckooMatrix::det(self : DshashcuckooMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DshashcuckooMatrix::norm(self : DshashcuckooMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DshashcuckooMatrix::to_string(self : DshashcuckooMatrix) -> String {
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

pub(all) struct DshashcuckooVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_cuckoo_make_vector(comps : Array[Double]) -> DshashcuckooVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_cuckoo_vector_zero(dim : Int) -> DshashcuckooVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DshashcuckooVector::add(self : DshashcuckooVector, other : DshashcuckooVector) -> DshashcuckooVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DshashcuckooVector::sub(self : DshashcuckooVector, other : DshashcuckooVector) -> DshashcuckooVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DshashcuckooVector::scale(self : DshashcuckooVector, s : Double) -> DshashcuckooVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DshashcuckooVector::dot(self : DshashcuckooVector, other : DshashcuckooVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DshashcuckooVector::norm(self : DshashcuckooVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DshashcuckooVector::normalize(self : DshashcuckooVector) -> DshashcuckooVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashcuckooVector::dist(self : DshashcuckooVector, other : DshashcuckooVector) -> Double {
  self.sub(other).norm()
}

pub fn DshashcuckooVector::to_string(self : DshashcuckooVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashcuckooFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_frame_make(size : Int) -> DshashcuckooFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashcuckooFrame::len(self : DshashcuckooFrame) -> Int { self.size }

pub fn DshashcuckooFrame::get(self : DshashcuckooFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashcuckooFrame::set(self : DshashcuckooFrame, i : Int, v : Double) -> DshashcuckooFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashcuckooFrame::sum(self : DshashcuckooFrame) -> Double { @_common.sum(self.data) }

pub fn DshashcuckooFrame::mean(self : DshashcuckooFrame) -> Double { @_common.mean(self.data) }

pub fn DshashcuckooFrame::scale(self : DshashcuckooFrame, f : Double) -> DshashcuckooFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashcuckooFrame::add(self : DshashcuckooFrame, other : DshashcuckooFrame) -> DshashcuckooFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashcuckooFrame::copy(self : DshashcuckooFrame) -> DshashcuckooFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashcuckooFrame::fill(self : DshashcuckooFrame, v : Double) -> DshashcuckooFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashcuckooFrame::min(self : DshashcuckooFrame) -> Double { @_common.min(self.data) }

pub fn DshashcuckooFrame::max(self : DshashcuckooFrame) -> Double { @_common.max(self.data) }

pub fn DshashcuckooFrame::to_string(self : DshashcuckooFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashcuckooTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_table_make(size : Int) -> DshashcuckooTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashcuckooTable::len(self : DshashcuckooTable) -> Int { self.size }

pub fn DshashcuckooTable::get(self : DshashcuckooTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashcuckooTable::set(self : DshashcuckooTable, i : Int, v : Double) -> DshashcuckooTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashcuckooTable::sum(self : DshashcuckooTable) -> Double { @_common.sum(self.data) }

pub fn DshashcuckooTable::mean(self : DshashcuckooTable) -> Double { @_common.mean(self.data) }

pub fn DshashcuckooTable::scale(self : DshashcuckooTable, f : Double) -> DshashcuckooTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashcuckooTable::add(self : DshashcuckooTable, other : DshashcuckooTable) -> DshashcuckooTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashcuckooTable::copy(self : DshashcuckooTable) -> DshashcuckooTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashcuckooTable::fill(self : DshashcuckooTable, v : Double) -> DshashcuckooTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashcuckooTable::min(self : DshashcuckooTable) -> Double { @_common.min(self.data) }

pub fn DshashcuckooTable::max(self : DshashcuckooTable) -> Double { @_common.max(self.data) }

pub fn DshashcuckooTable::to_string(self : DshashcuckooTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashcuckooGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_graphn_make(size : Int) -> DshashcuckooGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashcuckooGraphN::len(self : DshashcuckooGraphN) -> Int { self.size }

pub fn DshashcuckooGraphN::get(self : DshashcuckooGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashcuckooGraphN::set(self : DshashcuckooGraphN, i : Int, v : Double) -> DshashcuckooGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashcuckooGraphN::sum(self : DshashcuckooGraphN) -> Double { @_common.sum(self.data) }

pub fn DshashcuckooGraphN::mean(self : DshashcuckooGraphN) -> Double { @_common.mean(self.data) }

pub fn DshashcuckooGraphN::scale(self : DshashcuckooGraphN, f : Double) -> DshashcuckooGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashcuckooGraphN::add(self : DshashcuckooGraphN, other : DshashcuckooGraphN) -> DshashcuckooGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashcuckooGraphN::copy(self : DshashcuckooGraphN) -> DshashcuckooGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashcuckooGraphN::fill(self : DshashcuckooGraphN, v : Double) -> DshashcuckooGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashcuckooGraphN::min(self : DshashcuckooGraphN) -> Double { @_common.min(self.data) }

pub fn DshashcuckooGraphN::max(self : DshashcuckooGraphN) -> Double { @_common.max(self.data) }

pub fn DshashcuckooGraphN::to_string(self : DshashcuckooGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashcuckooNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_node_make(size : Int) -> DshashcuckooNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashcuckooNode::len(self : DshashcuckooNode) -> Int { self.size }

pub fn DshashcuckooNode::get(self : DshashcuckooNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashcuckooNode::set(self : DshashcuckooNode, i : Int, v : Double) -> DshashcuckooNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashcuckooNode::sum(self : DshashcuckooNode) -> Double { @_common.sum(self.data) }

pub fn DshashcuckooNode::mean(self : DshashcuckooNode) -> Double { @_common.mean(self.data) }

pub fn DshashcuckooNode::scale(self : DshashcuckooNode, f : Double) -> DshashcuckooNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashcuckooNode::add(self : DshashcuckooNode, other : DshashcuckooNode) -> DshashcuckooNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashcuckooNode::copy(self : DshashcuckooNode) -> DshashcuckooNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashcuckooNode::fill(self : DshashcuckooNode, v : Double) -> DshashcuckooNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashcuckooNode::min(self : DshashcuckooNode) -> Double { @_common.min(self.data) }

pub fn DshashcuckooNode::max(self : DshashcuckooNode) -> Double { @_common.max(self.data) }

pub fn DshashcuckooNode::to_string(self : DshashcuckooNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashcuckooEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_edge_make(size : Int) -> DshashcuckooEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashcuckooEdge::len(self : DshashcuckooEdge) -> Int { self.size }

pub fn DshashcuckooEdge::get(self : DshashcuckooEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashcuckooEdge::set(self : DshashcuckooEdge, i : Int, v : Double) -> DshashcuckooEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashcuckooEdge::sum(self : DshashcuckooEdge) -> Double { @_common.sum(self.data) }

pub fn DshashcuckooEdge::mean(self : DshashcuckooEdge) -> Double { @_common.mean(self.data) }

pub fn DshashcuckooEdge::scale(self : DshashcuckooEdge, f : Double) -> DshashcuckooEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashcuckooEdge::add(self : DshashcuckooEdge, other : DshashcuckooEdge) -> DshashcuckooEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashcuckooEdge::copy(self : DshashcuckooEdge) -> DshashcuckooEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashcuckooEdge::fill(self : DshashcuckooEdge, v : Double) -> DshashcuckooEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashcuckooEdge::min(self : DshashcuckooEdge) -> Double { @_common.min(self.data) }

pub fn DshashcuckooEdge::max(self : DshashcuckooEdge) -> Double { @_common.max(self.data) }

pub fn DshashcuckooEdge::to_string(self : DshashcuckooEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashcuckooPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_path_make(size : Int) -> DshashcuckooPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashcuckooPath::len(self : DshashcuckooPath) -> Int { self.size }

pub fn DshashcuckooPath::get(self : DshashcuckooPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashcuckooPath::set(self : DshashcuckooPath, i : Int, v : Double) -> DshashcuckooPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashcuckooPath::sum(self : DshashcuckooPath) -> Double { @_common.sum(self.data) }

pub fn DshashcuckooPath::mean(self : DshashcuckooPath) -> Double { @_common.mean(self.data) }

pub fn DshashcuckooPath::scale(self : DshashcuckooPath, f : Double) -> DshashcuckooPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashcuckooPath::add(self : DshashcuckooPath, other : DshashcuckooPath) -> DshashcuckooPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashcuckooPath::copy(self : DshashcuckooPath) -> DshashcuckooPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashcuckooPath::fill(self : DshashcuckooPath, v : Double) -> DshashcuckooPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashcuckooPath::min(self : DshashcuckooPath) -> Double { @_common.min(self.data) }

pub fn DshashcuckooPath::max(self : DshashcuckooPath) -> Double { @_common.max(self.data) }

pub fn DshashcuckooPath::to_string(self : DshashcuckooPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashcuckooCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_cluster_make(size : Int) -> DshashcuckooCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashcuckooCluster::len(self : DshashcuckooCluster) -> Int { self.size }

pub fn DshashcuckooCluster::get(self : DshashcuckooCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashcuckooCluster::set(self : DshashcuckooCluster, i : Int, v : Double) -> DshashcuckooCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashcuckooCluster::sum(self : DshashcuckooCluster) -> Double { @_common.sum(self.data) }

pub fn DshashcuckooCluster::mean(self : DshashcuckooCluster) -> Double { @_common.mean(self.data) }

pub fn DshashcuckooCluster::scale(self : DshashcuckooCluster, f : Double) -> DshashcuckooCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashcuckooCluster::add(self : DshashcuckooCluster, other : DshashcuckooCluster) -> DshashcuckooCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashcuckooCluster::copy(self : DshashcuckooCluster) -> DshashcuckooCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashcuckooCluster::fill(self : DshashcuckooCluster, v : Double) -> DshashcuckooCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashcuckooCluster::min(self : DshashcuckooCluster) -> Double { @_common.min(self.data) }

pub fn DshashcuckooCluster::max(self : DshashcuckooCluster) -> Double { @_common.max(self.data) }

pub fn DshashcuckooCluster::to_string(self : DshashcuckooCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashcuckooModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_model_make(size : Int) -> DshashcuckooModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashcuckooModel::len(self : DshashcuckooModel) -> Int { self.size }

pub fn DshashcuckooModel::get(self : DshashcuckooModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashcuckooModel::set(self : DshashcuckooModel, i : Int, v : Double) -> DshashcuckooModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashcuckooModel::sum(self : DshashcuckooModel) -> Double { @_common.sum(self.data) }

pub fn DshashcuckooModel::mean(self : DshashcuckooModel) -> Double { @_common.mean(self.data) }

pub fn DshashcuckooModel::scale(self : DshashcuckooModel, f : Double) -> DshashcuckooModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashcuckooModel::add(self : DshashcuckooModel, other : DshashcuckooModel) -> DshashcuckooModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashcuckooModel::copy(self : DshashcuckooModel) -> DshashcuckooModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashcuckooModel::fill(self : DshashcuckooModel, v : Double) -> DshashcuckooModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashcuckooModel::min(self : DshashcuckooModel) -> Double { @_common.min(self.data) }

pub fn DshashcuckooModel::max(self : DshashcuckooModel) -> Double { @_common.max(self.data) }

pub fn DshashcuckooModel::to_string(self : DshashcuckooModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashcuckooLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_layer_make(size : Int) -> DshashcuckooLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashcuckooLayer::len(self : DshashcuckooLayer) -> Int { self.size }

pub fn DshashcuckooLayer::get(self : DshashcuckooLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashcuckooLayer::set(self : DshashcuckooLayer, i : Int, v : Double) -> DshashcuckooLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashcuckooLayer::sum(self : DshashcuckooLayer) -> Double { @_common.sum(self.data) }

pub fn DshashcuckooLayer::mean(self : DshashcuckooLayer) -> Double { @_common.mean(self.data) }

pub fn DshashcuckooLayer::scale(self : DshashcuckooLayer, f : Double) -> DshashcuckooLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashcuckooLayer::add(self : DshashcuckooLayer, other : DshashcuckooLayer) -> DshashcuckooLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashcuckooLayer::copy(self : DshashcuckooLayer) -> DshashcuckooLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashcuckooLayer::fill(self : DshashcuckooLayer, v : Double) -> DshashcuckooLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashcuckooLayer::min(self : DshashcuckooLayer) -> Double { @_common.min(self.data) }

pub fn DshashcuckooLayer::max(self : DshashcuckooLayer) -> Double { @_common.max(self.data) }

pub fn DshashcuckooLayer::to_string(self : DshashcuckooLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashcuckooBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_buffer_make(size : Int) -> DshashcuckooBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashcuckooBuffer::len(self : DshashcuckooBuffer) -> Int { self.size }

pub fn DshashcuckooBuffer::get(self : DshashcuckooBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashcuckooBuffer::set(self : DshashcuckooBuffer, i : Int, v : Double) -> DshashcuckooBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashcuckooBuffer::sum(self : DshashcuckooBuffer) -> Double { @_common.sum(self.data) }

pub fn DshashcuckooBuffer::mean(self : DshashcuckooBuffer) -> Double { @_common.mean(self.data) }

pub fn DshashcuckooBuffer::scale(self : DshashcuckooBuffer, f : Double) -> DshashcuckooBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashcuckooBuffer::add(self : DshashcuckooBuffer, other : DshashcuckooBuffer) -> DshashcuckooBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashcuckooBuffer::copy(self : DshashcuckooBuffer) -> DshashcuckooBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashcuckooBuffer::fill(self : DshashcuckooBuffer, v : Double) -> DshashcuckooBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashcuckooBuffer::min(self : DshashcuckooBuffer) -> Double { @_common.min(self.data) }

pub fn DshashcuckooBuffer::max(self : DshashcuckooBuffer) -> Double { @_common.max(self.data) }

pub fn DshashcuckooBuffer::to_string(self : DshashcuckooBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashcuckooCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_cursor_make(size : Int) -> DshashcuckooCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashcuckooCursor::len(self : DshashcuckooCursor) -> Int { self.size }

pub fn DshashcuckooCursor::get(self : DshashcuckooCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashcuckooCursor::set(self : DshashcuckooCursor, i : Int, v : Double) -> DshashcuckooCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashcuckooCursor::sum(self : DshashcuckooCursor) -> Double { @_common.sum(self.data) }

pub fn DshashcuckooCursor::mean(self : DshashcuckooCursor) -> Double { @_common.mean(self.data) }

pub fn DshashcuckooCursor::scale(self : DshashcuckooCursor, f : Double) -> DshashcuckooCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashcuckooCursor::add(self : DshashcuckooCursor, other : DshashcuckooCursor) -> DshashcuckooCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashcuckooCursor::copy(self : DshashcuckooCursor) -> DshashcuckooCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashcuckooCursor::fill(self : DshashcuckooCursor, v : Double) -> DshashcuckooCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashcuckooCursor::min(self : DshashcuckooCursor) -> Double { @_common.min(self.data) }

pub fn DshashcuckooCursor::max(self : DshashcuckooCursor) -> Double { @_common.max(self.data) }

pub fn DshashcuckooCursor::to_string(self : DshashcuckooCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashcuckooView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_view_make(size : Int) -> DshashcuckooView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashcuckooView::len(self : DshashcuckooView) -> Int { self.size }

pub fn DshashcuckooView::get(self : DshashcuckooView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashcuckooView::set(self : DshashcuckooView, i : Int, v : Double) -> DshashcuckooView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashcuckooView::sum(self : DshashcuckooView) -> Double { @_common.sum(self.data) }

pub fn DshashcuckooView::mean(self : DshashcuckooView) -> Double { @_common.mean(self.data) }

pub fn DshashcuckooView::scale(self : DshashcuckooView, f : Double) -> DshashcuckooView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashcuckooView::add(self : DshashcuckooView, other : DshashcuckooView) -> DshashcuckooView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashcuckooView::copy(self : DshashcuckooView) -> DshashcuckooView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashcuckooView::fill(self : DshashcuckooView, v : Double) -> DshashcuckooView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashcuckooView::min(self : DshashcuckooView) -> Double { @_common.min(self.data) }

pub fn DshashcuckooView::max(self : DshashcuckooView) -> Double { @_common.max(self.data) }

pub fn DshashcuckooView::to_string(self : DshashcuckooView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashcuckooRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_range_make(size : Int) -> DshashcuckooRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashcuckooRange::len(self : DshashcuckooRange) -> Int { self.size }

pub fn DshashcuckooRange::get(self : DshashcuckooRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashcuckooRange::set(self : DshashcuckooRange, i : Int, v : Double) -> DshashcuckooRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashcuckooRange::sum(self : DshashcuckooRange) -> Double { @_common.sum(self.data) }

pub fn DshashcuckooRange::mean(self : DshashcuckooRange) -> Double { @_common.mean(self.data) }

pub fn DshashcuckooRange::scale(self : DshashcuckooRange, f : Double) -> DshashcuckooRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashcuckooRange::add(self : DshashcuckooRange, other : DshashcuckooRange) -> DshashcuckooRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashcuckooRange::copy(self : DshashcuckooRange) -> DshashcuckooRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashcuckooRange::fill(self : DshashcuckooRange, v : Double) -> DshashcuckooRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashcuckooRange::min(self : DshashcuckooRange) -> Double { @_common.min(self.data) }

pub fn DshashcuckooRange::max(self : DshashcuckooRange) -> Double { @_common.max(self.data) }

pub fn DshashcuckooRange::to_string(self : DshashcuckooRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashcuckooSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_slice_make(size : Int) -> DshashcuckooSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashcuckooSlice::len(self : DshashcuckooSlice) -> Int { self.size }

pub fn DshashcuckooSlice::get(self : DshashcuckooSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashcuckooSlice::set(self : DshashcuckooSlice, i : Int, v : Double) -> DshashcuckooSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashcuckooSlice::sum(self : DshashcuckooSlice) -> Double { @_common.sum(self.data) }

pub fn DshashcuckooSlice::mean(self : DshashcuckooSlice) -> Double { @_common.mean(self.data) }

pub fn DshashcuckooSlice::scale(self : DshashcuckooSlice, f : Double) -> DshashcuckooSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashcuckooSlice::add(self : DshashcuckooSlice, other : DshashcuckooSlice) -> DshashcuckooSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashcuckooSlice::copy(self : DshashcuckooSlice) -> DshashcuckooSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashcuckooSlice::fill(self : DshashcuckooSlice, v : Double) -> DshashcuckooSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashcuckooSlice::min(self : DshashcuckooSlice) -> Double { @_common.min(self.data) }

pub fn DshashcuckooSlice::max(self : DshashcuckooSlice) -> Double { @_common.max(self.data) }

pub fn DshashcuckooSlice::to_string(self : DshashcuckooSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

