///===
/// extcore/bio_seq_align_consistency

pub(all) struct BioseqalignconsistencyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_consistency_make_point(x : Double, y : Double) -> BioseqalignconsistencyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_consistency_make_point3(x : Double, y : Double, z : Double) -> BioseqalignconsistencyPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqalignconsistencyPoint::x(self : BioseqalignconsistencyPoint) -> Double { self.x }

pub fn BioseqalignconsistencyPoint::y(self : BioseqalignconsistencyPoint) -> Double { self.y }

pub fn BioseqalignconsistencyPoint::z(self : BioseqalignconsistencyPoint) -> Double { self.z }

pub fn BioseqalignconsistencyPoint::label(self : BioseqalignconsistencyPoint) -> Int { self.label }

pub fn BioseqalignconsistencyPoint::dist(self : BioseqalignconsistencyPoint, other : BioseqalignconsistencyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqalignconsistencyPoint::add(self : BioseqalignconsistencyPoint, other : BioseqalignconsistencyPoint) -> BioseqalignconsistencyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqalignconsistencyPoint::sub(self : BioseqalignconsistencyPoint, other : BioseqalignconsistencyPoint) -> BioseqalignconsistencyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqalignconsistencyPoint::scale(self : BioseqalignconsistencyPoint, s : Double) -> BioseqalignconsistencyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqalignconsistencyPoint::dot(self : BioseqalignconsistencyPoint, other : BioseqalignconsistencyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqalignconsistencyPoint::cross(self : BioseqalignconsistencyPoint, other : BioseqalignconsistencyPoint) -> BioseqalignconsistencyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqalignconsistencyPoint::norm(self : BioseqalignconsistencyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqalignconsistencyPoint::normalize(self : BioseqalignconsistencyPoint) -> BioseqalignconsistencyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignconsistencyPoint::negate(self : BioseqalignconsistencyPoint) -> BioseqalignconsistencyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqalignconsistencyPoint::mid(self : BioseqalignconsistencyPoint, other : BioseqalignconsistencyPoint) -> BioseqalignconsistencyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqalignconsistencyPoint::lerp(self : BioseqalignconsistencyPoint, other : BioseqalignconsistencyPoint, t : Double) -> BioseqalignconsistencyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqalignconsistencyPoint::to_string(self : BioseqalignconsistencyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqalignconsistencySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_consistency_make_series(vals : Array[Double], name : String) -> BioseqalignconsistencySeries {
  { vals, name, meta: 0 }
}

pub fn BioseqalignconsistencySeries::len(self : BioseqalignconsistencySeries) -> Int { self.vals.length() }

pub fn BioseqalignconsistencySeries::sum(self : BioseqalignconsistencySeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqalignconsistencySeries::mean(self : BioseqalignconsistencySeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqalignconsistencySeries::min(self : BioseqalignconsistencySeries) -> Double { @_common.min(self.vals) }

pub fn BioseqalignconsistencySeries::max(self : BioseqalignconsistencySeries) -> Double { @_common.max(self.vals) }

pub fn BioseqalignconsistencySeries::range(self : BioseqalignconsistencySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqalignconsistencySeries::variance(self : BioseqalignconsistencySeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqalignconsistencySeries::std(self : BioseqalignconsistencySeries) -> Double { @_common.std(self.vals) }

pub fn BioseqalignconsistencySeries::median(self : BioseqalignconsistencySeries) -> Double { @_common.median(self.vals) }

pub fn BioseqalignconsistencySeries::scale(self : BioseqalignconsistencySeries, f : Double) -> BioseqalignconsistencySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqalignconsistencySeries::add(self : BioseqalignconsistencySeries, other : BioseqalignconsistencySeries) -> BioseqalignconsistencySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqalignconsistencySeries::sub(self : BioseqalignconsistencySeries, other : BioseqalignconsistencySeries) -> BioseqalignconsistencySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqalignconsistencySeries::normalize(self : BioseqalignconsistencySeries) -> BioseqalignconsistencySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqalignconsistencySeries::cumsum(self : BioseqalignconsistencySeries) -> BioseqalignconsistencySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqalignconsistencySeries::to_string(self : BioseqalignconsistencySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignconsistencyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_consistency_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignconsistencyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_consistency_matrix_identity(n : Int) -> BioseqalignconsistencyMatrix {
  let m = bio_seq_align_consistency_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqalignconsistencyMatrix::get(self : BioseqalignconsistencyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqalignconsistencyMatrix::transpose(self : BioseqalignconsistencyMatrix) -> BioseqalignconsistencyMatrix {
  let result = bio_seq_align_consistency_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqalignconsistencyMatrix::add(self : BioseqalignconsistencyMatrix, other : BioseqalignconsistencyMatrix) -> BioseqalignconsistencyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_align_consistency_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqalignconsistencyMatrix::scale(self : BioseqalignconsistencyMatrix, s : Double) -> BioseqalignconsistencyMatrix {
  let result = bio_seq_align_consistency_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqalignconsistencyMatrix::multiply(self : BioseqalignconsistencyMatrix, other : BioseqalignconsistencyMatrix) -> BioseqalignconsistencyMatrix {
  if self.cols != other.rows { return bio_seq_align_consistency_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_align_consistency_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn BioseqalignconsistencyMatrix::trace(self : BioseqalignconsistencyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqalignconsistencyMatrix::det(self : BioseqalignconsistencyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqalignconsistencyMatrix::norm(self : BioseqalignconsistencyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqalignconsistencyMatrix::to_string(self : BioseqalignconsistencyMatrix) -> String {
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

pub(all) struct BioseqalignconsistencyVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_consistency_make_vector(comps : Array[Double]) -> BioseqalignconsistencyVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_consistency_vector_zero(dim : Int) -> BioseqalignconsistencyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqalignconsistencyVector::add(self : BioseqalignconsistencyVector, other : BioseqalignconsistencyVector) -> BioseqalignconsistencyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignconsistencyVector::sub(self : BioseqalignconsistencyVector, other : BioseqalignconsistencyVector) -> BioseqalignconsistencyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignconsistencyVector::scale(self : BioseqalignconsistencyVector, s : Double) -> BioseqalignconsistencyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqalignconsistencyVector::dot(self : BioseqalignconsistencyVector, other : BioseqalignconsistencyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqalignconsistencyVector::norm(self : BioseqalignconsistencyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqalignconsistencyVector::normalize(self : BioseqalignconsistencyVector) -> BioseqalignconsistencyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignconsistencyVector::dist(self : BioseqalignconsistencyVector, other : BioseqalignconsistencyVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqalignconsistencyVector::to_string(self : BioseqalignconsistencyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignconsistencyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_frame_make(size : Int) -> BioseqalignconsistencyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignconsistencyFrame::len(self : BioseqalignconsistencyFrame) -> Int { self.size }

pub fn BioseqalignconsistencyFrame::get(self : BioseqalignconsistencyFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignconsistencyFrame::set(self : BioseqalignconsistencyFrame, i : Int, v : Double) -> BioseqalignconsistencyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyFrame::sum(self : BioseqalignconsistencyFrame) -> Double { @_common.sum(self.data) }

pub fn BioseqalignconsistencyFrame::mean(self : BioseqalignconsistencyFrame) -> Double { @_common.mean(self.data) }

pub fn BioseqalignconsistencyFrame::scale(self : BioseqalignconsistencyFrame, f : Double) -> BioseqalignconsistencyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyFrame::add(self : BioseqalignconsistencyFrame, other : BioseqalignconsistencyFrame) -> BioseqalignconsistencyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignconsistencyFrame::copy(self : BioseqalignconsistencyFrame) -> BioseqalignconsistencyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyFrame::fill(self : BioseqalignconsistencyFrame, v : Double) -> BioseqalignconsistencyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyFrame::min(self : BioseqalignconsistencyFrame) -> Double { @_common.min(self.data) }

pub fn BioseqalignconsistencyFrame::max(self : BioseqalignconsistencyFrame) -> Double { @_common.max(self.data) }

pub fn BioseqalignconsistencyFrame::to_string(self : BioseqalignconsistencyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_table_make(size : Int) -> BioseqalignconsistencyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignconsistencyTable::len(self : BioseqalignconsistencyTable) -> Int { self.size }

pub fn BioseqalignconsistencyTable::get(self : BioseqalignconsistencyTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignconsistencyTable::set(self : BioseqalignconsistencyTable, i : Int, v : Double) -> BioseqalignconsistencyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyTable::sum(self : BioseqalignconsistencyTable) -> Double { @_common.sum(self.data) }

pub fn BioseqalignconsistencyTable::mean(self : BioseqalignconsistencyTable) -> Double { @_common.mean(self.data) }

pub fn BioseqalignconsistencyTable::scale(self : BioseqalignconsistencyTable, f : Double) -> BioseqalignconsistencyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyTable::add(self : BioseqalignconsistencyTable, other : BioseqalignconsistencyTable) -> BioseqalignconsistencyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignconsistencyTable::copy(self : BioseqalignconsistencyTable) -> BioseqalignconsistencyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyTable::fill(self : BioseqalignconsistencyTable, v : Double) -> BioseqalignconsistencyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyTable::min(self : BioseqalignconsistencyTable) -> Double { @_common.min(self.data) }

pub fn BioseqalignconsistencyTable::max(self : BioseqalignconsistencyTable) -> Double { @_common.max(self.data) }

pub fn BioseqalignconsistencyTable::to_string(self : BioseqalignconsistencyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_graphn_make(size : Int) -> BioseqalignconsistencyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignconsistencyGraphN::len(self : BioseqalignconsistencyGraphN) -> Int { self.size }

pub fn BioseqalignconsistencyGraphN::get(self : BioseqalignconsistencyGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignconsistencyGraphN::set(self : BioseqalignconsistencyGraphN, i : Int, v : Double) -> BioseqalignconsistencyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyGraphN::sum(self : BioseqalignconsistencyGraphN) -> Double { @_common.sum(self.data) }

pub fn BioseqalignconsistencyGraphN::mean(self : BioseqalignconsistencyGraphN) -> Double { @_common.mean(self.data) }

pub fn BioseqalignconsistencyGraphN::scale(self : BioseqalignconsistencyGraphN, f : Double) -> BioseqalignconsistencyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyGraphN::add(self : BioseqalignconsistencyGraphN, other : BioseqalignconsistencyGraphN) -> BioseqalignconsistencyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignconsistencyGraphN::copy(self : BioseqalignconsistencyGraphN) -> BioseqalignconsistencyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyGraphN::fill(self : BioseqalignconsistencyGraphN, v : Double) -> BioseqalignconsistencyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyGraphN::min(self : BioseqalignconsistencyGraphN) -> Double { @_common.min(self.data) }

pub fn BioseqalignconsistencyGraphN::max(self : BioseqalignconsistencyGraphN) -> Double { @_common.max(self.data) }

pub fn BioseqalignconsistencyGraphN::to_string(self : BioseqalignconsistencyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_node_make(size : Int) -> BioseqalignconsistencyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignconsistencyNode::len(self : BioseqalignconsistencyNode) -> Int { self.size }

pub fn BioseqalignconsistencyNode::get(self : BioseqalignconsistencyNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignconsistencyNode::set(self : BioseqalignconsistencyNode, i : Int, v : Double) -> BioseqalignconsistencyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyNode::sum(self : BioseqalignconsistencyNode) -> Double { @_common.sum(self.data) }

pub fn BioseqalignconsistencyNode::mean(self : BioseqalignconsistencyNode) -> Double { @_common.mean(self.data) }

pub fn BioseqalignconsistencyNode::scale(self : BioseqalignconsistencyNode, f : Double) -> BioseqalignconsistencyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyNode::add(self : BioseqalignconsistencyNode, other : BioseqalignconsistencyNode) -> BioseqalignconsistencyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignconsistencyNode::copy(self : BioseqalignconsistencyNode) -> BioseqalignconsistencyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyNode::fill(self : BioseqalignconsistencyNode, v : Double) -> BioseqalignconsistencyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyNode::min(self : BioseqalignconsistencyNode) -> Double { @_common.min(self.data) }

pub fn BioseqalignconsistencyNode::max(self : BioseqalignconsistencyNode) -> Double { @_common.max(self.data) }

pub fn BioseqalignconsistencyNode::to_string(self : BioseqalignconsistencyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_edge_make(size : Int) -> BioseqalignconsistencyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignconsistencyEdge::len(self : BioseqalignconsistencyEdge) -> Int { self.size }

pub fn BioseqalignconsistencyEdge::get(self : BioseqalignconsistencyEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignconsistencyEdge::set(self : BioseqalignconsistencyEdge, i : Int, v : Double) -> BioseqalignconsistencyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyEdge::sum(self : BioseqalignconsistencyEdge) -> Double { @_common.sum(self.data) }

pub fn BioseqalignconsistencyEdge::mean(self : BioseqalignconsistencyEdge) -> Double { @_common.mean(self.data) }

pub fn BioseqalignconsistencyEdge::scale(self : BioseqalignconsistencyEdge, f : Double) -> BioseqalignconsistencyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyEdge::add(self : BioseqalignconsistencyEdge, other : BioseqalignconsistencyEdge) -> BioseqalignconsistencyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignconsistencyEdge::copy(self : BioseqalignconsistencyEdge) -> BioseqalignconsistencyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyEdge::fill(self : BioseqalignconsistencyEdge, v : Double) -> BioseqalignconsistencyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyEdge::min(self : BioseqalignconsistencyEdge) -> Double { @_common.min(self.data) }

pub fn BioseqalignconsistencyEdge::max(self : BioseqalignconsistencyEdge) -> Double { @_common.max(self.data) }

pub fn BioseqalignconsistencyEdge::to_string(self : BioseqalignconsistencyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_path_make(size : Int) -> BioseqalignconsistencyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignconsistencyPath::len(self : BioseqalignconsistencyPath) -> Int { self.size }

pub fn BioseqalignconsistencyPath::get(self : BioseqalignconsistencyPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignconsistencyPath::set(self : BioseqalignconsistencyPath, i : Int, v : Double) -> BioseqalignconsistencyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyPath::sum(self : BioseqalignconsistencyPath) -> Double { @_common.sum(self.data) }

pub fn BioseqalignconsistencyPath::mean(self : BioseqalignconsistencyPath) -> Double { @_common.mean(self.data) }

pub fn BioseqalignconsistencyPath::scale(self : BioseqalignconsistencyPath, f : Double) -> BioseqalignconsistencyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyPath::add(self : BioseqalignconsistencyPath, other : BioseqalignconsistencyPath) -> BioseqalignconsistencyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignconsistencyPath::copy(self : BioseqalignconsistencyPath) -> BioseqalignconsistencyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyPath::fill(self : BioseqalignconsistencyPath, v : Double) -> BioseqalignconsistencyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyPath::min(self : BioseqalignconsistencyPath) -> Double { @_common.min(self.data) }

pub fn BioseqalignconsistencyPath::max(self : BioseqalignconsistencyPath) -> Double { @_common.max(self.data) }

pub fn BioseqalignconsistencyPath::to_string(self : BioseqalignconsistencyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_cluster_make(size : Int) -> BioseqalignconsistencyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignconsistencyCluster::len(self : BioseqalignconsistencyCluster) -> Int { self.size }

pub fn BioseqalignconsistencyCluster::get(self : BioseqalignconsistencyCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignconsistencyCluster::set(self : BioseqalignconsistencyCluster, i : Int, v : Double) -> BioseqalignconsistencyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyCluster::sum(self : BioseqalignconsistencyCluster) -> Double { @_common.sum(self.data) }

pub fn BioseqalignconsistencyCluster::mean(self : BioseqalignconsistencyCluster) -> Double { @_common.mean(self.data) }

pub fn BioseqalignconsistencyCluster::scale(self : BioseqalignconsistencyCluster, f : Double) -> BioseqalignconsistencyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyCluster::add(self : BioseqalignconsistencyCluster, other : BioseqalignconsistencyCluster) -> BioseqalignconsistencyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignconsistencyCluster::copy(self : BioseqalignconsistencyCluster) -> BioseqalignconsistencyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyCluster::fill(self : BioseqalignconsistencyCluster, v : Double) -> BioseqalignconsistencyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyCluster::min(self : BioseqalignconsistencyCluster) -> Double { @_common.min(self.data) }

pub fn BioseqalignconsistencyCluster::max(self : BioseqalignconsistencyCluster) -> Double { @_common.max(self.data) }

pub fn BioseqalignconsistencyCluster::to_string(self : BioseqalignconsistencyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_model_make(size : Int) -> BioseqalignconsistencyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignconsistencyModel::len(self : BioseqalignconsistencyModel) -> Int { self.size }

pub fn BioseqalignconsistencyModel::get(self : BioseqalignconsistencyModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignconsistencyModel::set(self : BioseqalignconsistencyModel, i : Int, v : Double) -> BioseqalignconsistencyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyModel::sum(self : BioseqalignconsistencyModel) -> Double { @_common.sum(self.data) }

pub fn BioseqalignconsistencyModel::mean(self : BioseqalignconsistencyModel) -> Double { @_common.mean(self.data) }

pub fn BioseqalignconsistencyModel::scale(self : BioseqalignconsistencyModel, f : Double) -> BioseqalignconsistencyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyModel::add(self : BioseqalignconsistencyModel, other : BioseqalignconsistencyModel) -> BioseqalignconsistencyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignconsistencyModel::copy(self : BioseqalignconsistencyModel) -> BioseqalignconsistencyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyModel::fill(self : BioseqalignconsistencyModel, v : Double) -> BioseqalignconsistencyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyModel::min(self : BioseqalignconsistencyModel) -> Double { @_common.min(self.data) }

pub fn BioseqalignconsistencyModel::max(self : BioseqalignconsistencyModel) -> Double { @_common.max(self.data) }

pub fn BioseqalignconsistencyModel::to_string(self : BioseqalignconsistencyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_layer_make(size : Int) -> BioseqalignconsistencyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignconsistencyLayer::len(self : BioseqalignconsistencyLayer) -> Int { self.size }

pub fn BioseqalignconsistencyLayer::get(self : BioseqalignconsistencyLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignconsistencyLayer::set(self : BioseqalignconsistencyLayer, i : Int, v : Double) -> BioseqalignconsistencyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyLayer::sum(self : BioseqalignconsistencyLayer) -> Double { @_common.sum(self.data) }

pub fn BioseqalignconsistencyLayer::mean(self : BioseqalignconsistencyLayer) -> Double { @_common.mean(self.data) }

pub fn BioseqalignconsistencyLayer::scale(self : BioseqalignconsistencyLayer, f : Double) -> BioseqalignconsistencyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyLayer::add(self : BioseqalignconsistencyLayer, other : BioseqalignconsistencyLayer) -> BioseqalignconsistencyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignconsistencyLayer::copy(self : BioseqalignconsistencyLayer) -> BioseqalignconsistencyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyLayer::fill(self : BioseqalignconsistencyLayer, v : Double) -> BioseqalignconsistencyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyLayer::min(self : BioseqalignconsistencyLayer) -> Double { @_common.min(self.data) }

pub fn BioseqalignconsistencyLayer::max(self : BioseqalignconsistencyLayer) -> Double { @_common.max(self.data) }

pub fn BioseqalignconsistencyLayer::to_string(self : BioseqalignconsistencyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_buffer_make(size : Int) -> BioseqalignconsistencyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignconsistencyBuffer::len(self : BioseqalignconsistencyBuffer) -> Int { self.size }

pub fn BioseqalignconsistencyBuffer::get(self : BioseqalignconsistencyBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignconsistencyBuffer::set(self : BioseqalignconsistencyBuffer, i : Int, v : Double) -> BioseqalignconsistencyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyBuffer::sum(self : BioseqalignconsistencyBuffer) -> Double { @_common.sum(self.data) }

pub fn BioseqalignconsistencyBuffer::mean(self : BioseqalignconsistencyBuffer) -> Double { @_common.mean(self.data) }

pub fn BioseqalignconsistencyBuffer::scale(self : BioseqalignconsistencyBuffer, f : Double) -> BioseqalignconsistencyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyBuffer::add(self : BioseqalignconsistencyBuffer, other : BioseqalignconsistencyBuffer) -> BioseqalignconsistencyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignconsistencyBuffer::copy(self : BioseqalignconsistencyBuffer) -> BioseqalignconsistencyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyBuffer::fill(self : BioseqalignconsistencyBuffer, v : Double) -> BioseqalignconsistencyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyBuffer::min(self : BioseqalignconsistencyBuffer) -> Double { @_common.min(self.data) }

pub fn BioseqalignconsistencyBuffer::max(self : BioseqalignconsistencyBuffer) -> Double { @_common.max(self.data) }

pub fn BioseqalignconsistencyBuffer::to_string(self : BioseqalignconsistencyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_cursor_make(size : Int) -> BioseqalignconsistencyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignconsistencyCursor::len(self : BioseqalignconsistencyCursor) -> Int { self.size }

pub fn BioseqalignconsistencyCursor::get(self : BioseqalignconsistencyCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignconsistencyCursor::set(self : BioseqalignconsistencyCursor, i : Int, v : Double) -> BioseqalignconsistencyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyCursor::sum(self : BioseqalignconsistencyCursor) -> Double { @_common.sum(self.data) }

pub fn BioseqalignconsistencyCursor::mean(self : BioseqalignconsistencyCursor) -> Double { @_common.mean(self.data) }

pub fn BioseqalignconsistencyCursor::scale(self : BioseqalignconsistencyCursor, f : Double) -> BioseqalignconsistencyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyCursor::add(self : BioseqalignconsistencyCursor, other : BioseqalignconsistencyCursor) -> BioseqalignconsistencyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignconsistencyCursor::copy(self : BioseqalignconsistencyCursor) -> BioseqalignconsistencyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyCursor::fill(self : BioseqalignconsistencyCursor, v : Double) -> BioseqalignconsistencyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyCursor::min(self : BioseqalignconsistencyCursor) -> Double { @_common.min(self.data) }

pub fn BioseqalignconsistencyCursor::max(self : BioseqalignconsistencyCursor) -> Double { @_common.max(self.data) }

pub fn BioseqalignconsistencyCursor::to_string(self : BioseqalignconsistencyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_view_make(size : Int) -> BioseqalignconsistencyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignconsistencyView::len(self : BioseqalignconsistencyView) -> Int { self.size }

pub fn BioseqalignconsistencyView::get(self : BioseqalignconsistencyView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignconsistencyView::set(self : BioseqalignconsistencyView, i : Int, v : Double) -> BioseqalignconsistencyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyView::sum(self : BioseqalignconsistencyView) -> Double { @_common.sum(self.data) }

pub fn BioseqalignconsistencyView::mean(self : BioseqalignconsistencyView) -> Double { @_common.mean(self.data) }

pub fn BioseqalignconsistencyView::scale(self : BioseqalignconsistencyView, f : Double) -> BioseqalignconsistencyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyView::add(self : BioseqalignconsistencyView, other : BioseqalignconsistencyView) -> BioseqalignconsistencyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignconsistencyView::copy(self : BioseqalignconsistencyView) -> BioseqalignconsistencyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyView::fill(self : BioseqalignconsistencyView, v : Double) -> BioseqalignconsistencyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyView::min(self : BioseqalignconsistencyView) -> Double { @_common.min(self.data) }

pub fn BioseqalignconsistencyView::max(self : BioseqalignconsistencyView) -> Double { @_common.max(self.data) }

pub fn BioseqalignconsistencyView::to_string(self : BioseqalignconsistencyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_range_make(size : Int) -> BioseqalignconsistencyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignconsistencyRange::len(self : BioseqalignconsistencyRange) -> Int { self.size }

pub fn BioseqalignconsistencyRange::get(self : BioseqalignconsistencyRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignconsistencyRange::set(self : BioseqalignconsistencyRange, i : Int, v : Double) -> BioseqalignconsistencyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyRange::sum(self : BioseqalignconsistencyRange) -> Double { @_common.sum(self.data) }

pub fn BioseqalignconsistencyRange::mean(self : BioseqalignconsistencyRange) -> Double { @_common.mean(self.data) }

pub fn BioseqalignconsistencyRange::scale(self : BioseqalignconsistencyRange, f : Double) -> BioseqalignconsistencyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyRange::add(self : BioseqalignconsistencyRange, other : BioseqalignconsistencyRange) -> BioseqalignconsistencyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignconsistencyRange::copy(self : BioseqalignconsistencyRange) -> BioseqalignconsistencyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyRange::fill(self : BioseqalignconsistencyRange, v : Double) -> BioseqalignconsistencyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencyRange::min(self : BioseqalignconsistencyRange) -> Double { @_common.min(self.data) }

pub fn BioseqalignconsistencyRange::max(self : BioseqalignconsistencyRange) -> Double { @_common.max(self.data) }

pub fn BioseqalignconsistencyRange::to_string(self : BioseqalignconsistencyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_slice_make(size : Int) -> BioseqalignconsistencySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignconsistencySlice::len(self : BioseqalignconsistencySlice) -> Int { self.size }

pub fn BioseqalignconsistencySlice::get(self : BioseqalignconsistencySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignconsistencySlice::set(self : BioseqalignconsistencySlice, i : Int, v : Double) -> BioseqalignconsistencySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencySlice::sum(self : BioseqalignconsistencySlice) -> Double { @_common.sum(self.data) }

pub fn BioseqalignconsistencySlice::mean(self : BioseqalignconsistencySlice) -> Double { @_common.mean(self.data) }

pub fn BioseqalignconsistencySlice::scale(self : BioseqalignconsistencySlice, f : Double) -> BioseqalignconsistencySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencySlice::add(self : BioseqalignconsistencySlice, other : BioseqalignconsistencySlice) -> BioseqalignconsistencySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignconsistencySlice::copy(self : BioseqalignconsistencySlice) -> BioseqalignconsistencySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencySlice::fill(self : BioseqalignconsistencySlice, v : Double) -> BioseqalignconsistencySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignconsistencySlice::min(self : BioseqalignconsistencySlice) -> Double { @_common.min(self.data) }

pub fn BioseqalignconsistencySlice::max(self : BioseqalignconsistencySlice) -> Double { @_common.max(self.data) }

pub fn BioseqalignconsistencySlice::to_string(self : BioseqalignconsistencySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

