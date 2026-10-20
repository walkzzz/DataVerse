///===
/// extcore/bio_seq_align_multiple

pub(all) struct BioseqalignmultiplePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_multiple_make_point(x : Double, y : Double) -> BioseqalignmultiplePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_multiple_make_point3(x : Double, y : Double, z : Double) -> BioseqalignmultiplePoint {
  { x, y, z, label: 0 }
}

pub fn BioseqalignmultiplePoint::x(self : BioseqalignmultiplePoint) -> Double { self.x }

pub fn BioseqalignmultiplePoint::y(self : BioseqalignmultiplePoint) -> Double { self.y }

pub fn BioseqalignmultiplePoint::z(self : BioseqalignmultiplePoint) -> Double { self.z }

pub fn BioseqalignmultiplePoint::label(self : BioseqalignmultiplePoint) -> Int { self.label }

pub fn BioseqalignmultiplePoint::dist(self : BioseqalignmultiplePoint, other : BioseqalignmultiplePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqalignmultiplePoint::add(self : BioseqalignmultiplePoint, other : BioseqalignmultiplePoint) -> BioseqalignmultiplePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqalignmultiplePoint::sub(self : BioseqalignmultiplePoint, other : BioseqalignmultiplePoint) -> BioseqalignmultiplePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqalignmultiplePoint::scale(self : BioseqalignmultiplePoint, s : Double) -> BioseqalignmultiplePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqalignmultiplePoint::dot(self : BioseqalignmultiplePoint, other : BioseqalignmultiplePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqalignmultiplePoint::cross(self : BioseqalignmultiplePoint, other : BioseqalignmultiplePoint) -> BioseqalignmultiplePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqalignmultiplePoint::norm(self : BioseqalignmultiplePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqalignmultiplePoint::normalize(self : BioseqalignmultiplePoint) -> BioseqalignmultiplePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignmultiplePoint::negate(self : BioseqalignmultiplePoint) -> BioseqalignmultiplePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqalignmultiplePoint::mid(self : BioseqalignmultiplePoint, other : BioseqalignmultiplePoint) -> BioseqalignmultiplePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqalignmultiplePoint::lerp(self : BioseqalignmultiplePoint, other : BioseqalignmultiplePoint, t : Double) -> BioseqalignmultiplePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqalignmultiplePoint::to_string(self : BioseqalignmultiplePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqalignmultipleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_multiple_make_series(vals : Array[Double], name : String) -> BioseqalignmultipleSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqalignmultipleSeries::len(self : BioseqalignmultipleSeries) -> Int { self.vals.length() }

pub fn BioseqalignmultipleSeries::sum(self : BioseqalignmultipleSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqalignmultipleSeries::mean(self : BioseqalignmultipleSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqalignmultipleSeries::min(self : BioseqalignmultipleSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqalignmultipleSeries::max(self : BioseqalignmultipleSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqalignmultipleSeries::range(self : BioseqalignmultipleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqalignmultipleSeries::variance(self : BioseqalignmultipleSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqalignmultipleSeries::std(self : BioseqalignmultipleSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqalignmultipleSeries::median(self : BioseqalignmultipleSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqalignmultipleSeries::scale(self : BioseqalignmultipleSeries, f : Double) -> BioseqalignmultipleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqalignmultipleSeries::add(self : BioseqalignmultipleSeries, other : BioseqalignmultipleSeries) -> BioseqalignmultipleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqalignmultipleSeries::sub(self : BioseqalignmultipleSeries, other : BioseqalignmultipleSeries) -> BioseqalignmultipleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqalignmultipleSeries::normalize(self : BioseqalignmultipleSeries) -> BioseqalignmultipleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqalignmultipleSeries::cumsum(self : BioseqalignmultipleSeries) -> BioseqalignmultipleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqalignmultipleSeries::to_string(self : BioseqalignmultipleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignmultipleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_multiple_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignmultipleMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn bio_seq_align_multiple_matrix_identity(n : Int) -> BioseqalignmultipleMatrix {
  let m = bio_seq_align_multiple_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqalignmultipleMatrix::get(self : BioseqalignmultipleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqalignmultipleMatrix::transpose(self : BioseqalignmultipleMatrix) -> BioseqalignmultipleMatrix {
  let result = bio_seq_align_multiple_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqalignmultipleMatrix::add(self : BioseqalignmultipleMatrix, other : BioseqalignmultipleMatrix) -> BioseqalignmultipleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_align_multiple_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqalignmultipleMatrix::scale(self : BioseqalignmultipleMatrix, s : Double) -> BioseqalignmultipleMatrix {
  let result = bio_seq_align_multiple_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqalignmultipleMatrix::multiply(self : BioseqalignmultipleMatrix, other : BioseqalignmultipleMatrix) -> BioseqalignmultipleMatrix {
  if self.cols != other.rows { return bio_seq_align_multiple_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_align_multiple_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn BioseqalignmultipleMatrix::trace(self : BioseqalignmultipleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqalignmultipleMatrix::det(self : BioseqalignmultipleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqalignmultipleMatrix::norm(self : BioseqalignmultipleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqalignmultipleMatrix::to_string(self : BioseqalignmultipleMatrix) -> String {
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

pub(all) struct BioseqalignmultipleVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_multiple_make_vector(comps : Array[Double]) -> BioseqalignmultipleVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_multiple_vector_zero(dim : Int) -> BioseqalignmultipleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqalignmultipleVector::add(self : BioseqalignmultipleVector, other : BioseqalignmultipleVector) -> BioseqalignmultipleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignmultipleVector::sub(self : BioseqalignmultipleVector, other : BioseqalignmultipleVector) -> BioseqalignmultipleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignmultipleVector::scale(self : BioseqalignmultipleVector, s : Double) -> BioseqalignmultipleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqalignmultipleVector::dot(self : BioseqalignmultipleVector, other : BioseqalignmultipleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqalignmultipleVector::norm(self : BioseqalignmultipleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqalignmultipleVector::normalize(self : BioseqalignmultipleVector) -> BioseqalignmultipleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignmultipleVector::dist(self : BioseqalignmultipleVector, other : BioseqalignmultipleVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqalignmultipleVector::to_string(self : BioseqalignmultipleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignmultipleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_frame_make(size : Int) -> BioseqalignmultipleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignmultipleFrame::len(self : BioseqalignmultipleFrame) -> Int { self.size }

pub fn BioseqalignmultipleFrame::get(self : BioseqalignmultipleFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignmultipleFrame::set(self : BioseqalignmultipleFrame, i : Int, v : Double) -> BioseqalignmultipleFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleFrame::sum(self : BioseqalignmultipleFrame) -> Double { @_common.sum(self.data) }

pub fn BioseqalignmultipleFrame::mean(self : BioseqalignmultipleFrame) -> Double { @_common.mean(self.data) }

pub fn BioseqalignmultipleFrame::scale(self : BioseqalignmultipleFrame, f : Double) -> BioseqalignmultipleFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleFrame::add(self : BioseqalignmultipleFrame, other : BioseqalignmultipleFrame) -> BioseqalignmultipleFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignmultipleFrame::copy(self : BioseqalignmultipleFrame) -> BioseqalignmultipleFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleFrame::fill(self : BioseqalignmultipleFrame, v : Double) -> BioseqalignmultipleFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleFrame::min(self : BioseqalignmultipleFrame) -> Double { @_common.min(self.data) }

pub fn BioseqalignmultipleFrame::max(self : BioseqalignmultipleFrame) -> Double { @_common.max(self.data) }

pub fn BioseqalignmultipleFrame::to_string(self : BioseqalignmultipleFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_table_make(size : Int) -> BioseqalignmultipleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignmultipleTable::len(self : BioseqalignmultipleTable) -> Int { self.size }

pub fn BioseqalignmultipleTable::get(self : BioseqalignmultipleTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignmultipleTable::set(self : BioseqalignmultipleTable, i : Int, v : Double) -> BioseqalignmultipleTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleTable::sum(self : BioseqalignmultipleTable) -> Double { @_common.sum(self.data) }

pub fn BioseqalignmultipleTable::mean(self : BioseqalignmultipleTable) -> Double { @_common.mean(self.data) }

pub fn BioseqalignmultipleTable::scale(self : BioseqalignmultipleTable, f : Double) -> BioseqalignmultipleTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleTable::add(self : BioseqalignmultipleTable, other : BioseqalignmultipleTable) -> BioseqalignmultipleTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignmultipleTable::copy(self : BioseqalignmultipleTable) -> BioseqalignmultipleTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleTable::fill(self : BioseqalignmultipleTable, v : Double) -> BioseqalignmultipleTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleTable::min(self : BioseqalignmultipleTable) -> Double { @_common.min(self.data) }

pub fn BioseqalignmultipleTable::max(self : BioseqalignmultipleTable) -> Double { @_common.max(self.data) }

pub fn BioseqalignmultipleTable::to_string(self : BioseqalignmultipleTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_graphn_make(size : Int) -> BioseqalignmultipleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignmultipleGraphN::len(self : BioseqalignmultipleGraphN) -> Int { self.size }

pub fn BioseqalignmultipleGraphN::get(self : BioseqalignmultipleGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignmultipleGraphN::set(self : BioseqalignmultipleGraphN, i : Int, v : Double) -> BioseqalignmultipleGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleGraphN::sum(self : BioseqalignmultipleGraphN) -> Double { @_common.sum(self.data) }

pub fn BioseqalignmultipleGraphN::mean(self : BioseqalignmultipleGraphN) -> Double { @_common.mean(self.data) }

pub fn BioseqalignmultipleGraphN::scale(self : BioseqalignmultipleGraphN, f : Double) -> BioseqalignmultipleGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleGraphN::add(self : BioseqalignmultipleGraphN, other : BioseqalignmultipleGraphN) -> BioseqalignmultipleGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignmultipleGraphN::copy(self : BioseqalignmultipleGraphN) -> BioseqalignmultipleGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleGraphN::fill(self : BioseqalignmultipleGraphN, v : Double) -> BioseqalignmultipleGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleGraphN::min(self : BioseqalignmultipleGraphN) -> Double { @_common.min(self.data) }

pub fn BioseqalignmultipleGraphN::max(self : BioseqalignmultipleGraphN) -> Double { @_common.max(self.data) }

pub fn BioseqalignmultipleGraphN::to_string(self : BioseqalignmultipleGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_node_make(size : Int) -> BioseqalignmultipleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignmultipleNode::len(self : BioseqalignmultipleNode) -> Int { self.size }

pub fn BioseqalignmultipleNode::get(self : BioseqalignmultipleNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignmultipleNode::set(self : BioseqalignmultipleNode, i : Int, v : Double) -> BioseqalignmultipleNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleNode::sum(self : BioseqalignmultipleNode) -> Double { @_common.sum(self.data) }

pub fn BioseqalignmultipleNode::mean(self : BioseqalignmultipleNode) -> Double { @_common.mean(self.data) }

pub fn BioseqalignmultipleNode::scale(self : BioseqalignmultipleNode, f : Double) -> BioseqalignmultipleNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleNode::add(self : BioseqalignmultipleNode, other : BioseqalignmultipleNode) -> BioseqalignmultipleNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignmultipleNode::copy(self : BioseqalignmultipleNode) -> BioseqalignmultipleNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleNode::fill(self : BioseqalignmultipleNode, v : Double) -> BioseqalignmultipleNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleNode::min(self : BioseqalignmultipleNode) -> Double { @_common.min(self.data) }

pub fn BioseqalignmultipleNode::max(self : BioseqalignmultipleNode) -> Double { @_common.max(self.data) }

pub fn BioseqalignmultipleNode::to_string(self : BioseqalignmultipleNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_edge_make(size : Int) -> BioseqalignmultipleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignmultipleEdge::len(self : BioseqalignmultipleEdge) -> Int { self.size }

pub fn BioseqalignmultipleEdge::get(self : BioseqalignmultipleEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignmultipleEdge::set(self : BioseqalignmultipleEdge, i : Int, v : Double) -> BioseqalignmultipleEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleEdge::sum(self : BioseqalignmultipleEdge) -> Double { @_common.sum(self.data) }

pub fn BioseqalignmultipleEdge::mean(self : BioseqalignmultipleEdge) -> Double { @_common.mean(self.data) }

pub fn BioseqalignmultipleEdge::scale(self : BioseqalignmultipleEdge, f : Double) -> BioseqalignmultipleEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleEdge::add(self : BioseqalignmultipleEdge, other : BioseqalignmultipleEdge) -> BioseqalignmultipleEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignmultipleEdge::copy(self : BioseqalignmultipleEdge) -> BioseqalignmultipleEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleEdge::fill(self : BioseqalignmultipleEdge, v : Double) -> BioseqalignmultipleEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleEdge::min(self : BioseqalignmultipleEdge) -> Double { @_common.min(self.data) }

pub fn BioseqalignmultipleEdge::max(self : BioseqalignmultipleEdge) -> Double { @_common.max(self.data) }

pub fn BioseqalignmultipleEdge::to_string(self : BioseqalignmultipleEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultiplePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_path_make(size : Int) -> BioseqalignmultiplePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignmultiplePath::len(self : BioseqalignmultiplePath) -> Int { self.size }

pub fn BioseqalignmultiplePath::get(self : BioseqalignmultiplePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignmultiplePath::set(self : BioseqalignmultiplePath, i : Int, v : Double) -> BioseqalignmultiplePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignmultiplePath::sum(self : BioseqalignmultiplePath) -> Double { @_common.sum(self.data) }

pub fn BioseqalignmultiplePath::mean(self : BioseqalignmultiplePath) -> Double { @_common.mean(self.data) }

pub fn BioseqalignmultiplePath::scale(self : BioseqalignmultiplePath, f : Double) -> BioseqalignmultiplePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultiplePath::add(self : BioseqalignmultiplePath, other : BioseqalignmultiplePath) -> BioseqalignmultiplePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignmultiplePath::copy(self : BioseqalignmultiplePath) -> BioseqalignmultiplePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultiplePath::fill(self : BioseqalignmultiplePath, v : Double) -> BioseqalignmultiplePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultiplePath::min(self : BioseqalignmultiplePath) -> Double { @_common.min(self.data) }

pub fn BioseqalignmultiplePath::max(self : BioseqalignmultiplePath) -> Double { @_common.max(self.data) }

pub fn BioseqalignmultiplePath::to_string(self : BioseqalignmultiplePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_cluster_make(size : Int) -> BioseqalignmultipleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignmultipleCluster::len(self : BioseqalignmultipleCluster) -> Int { self.size }

pub fn BioseqalignmultipleCluster::get(self : BioseqalignmultipleCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignmultipleCluster::set(self : BioseqalignmultipleCluster, i : Int, v : Double) -> BioseqalignmultipleCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleCluster::sum(self : BioseqalignmultipleCluster) -> Double { @_common.sum(self.data) }

pub fn BioseqalignmultipleCluster::mean(self : BioseqalignmultipleCluster) -> Double { @_common.mean(self.data) }

pub fn BioseqalignmultipleCluster::scale(self : BioseqalignmultipleCluster, f : Double) -> BioseqalignmultipleCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleCluster::add(self : BioseqalignmultipleCluster, other : BioseqalignmultipleCluster) -> BioseqalignmultipleCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignmultipleCluster::copy(self : BioseqalignmultipleCluster) -> BioseqalignmultipleCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleCluster::fill(self : BioseqalignmultipleCluster, v : Double) -> BioseqalignmultipleCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleCluster::min(self : BioseqalignmultipleCluster) -> Double { @_common.min(self.data) }

pub fn BioseqalignmultipleCluster::max(self : BioseqalignmultipleCluster) -> Double { @_common.max(self.data) }

pub fn BioseqalignmultipleCluster::to_string(self : BioseqalignmultipleCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_model_make(size : Int) -> BioseqalignmultipleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignmultipleModel::len(self : BioseqalignmultipleModel) -> Int { self.size }

pub fn BioseqalignmultipleModel::get(self : BioseqalignmultipleModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignmultipleModel::set(self : BioseqalignmultipleModel, i : Int, v : Double) -> BioseqalignmultipleModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleModel::sum(self : BioseqalignmultipleModel) -> Double { @_common.sum(self.data) }

pub fn BioseqalignmultipleModel::mean(self : BioseqalignmultipleModel) -> Double { @_common.mean(self.data) }

pub fn BioseqalignmultipleModel::scale(self : BioseqalignmultipleModel, f : Double) -> BioseqalignmultipleModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleModel::add(self : BioseqalignmultipleModel, other : BioseqalignmultipleModel) -> BioseqalignmultipleModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignmultipleModel::copy(self : BioseqalignmultipleModel) -> BioseqalignmultipleModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleModel::fill(self : BioseqalignmultipleModel, v : Double) -> BioseqalignmultipleModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleModel::min(self : BioseqalignmultipleModel) -> Double { @_common.min(self.data) }

pub fn BioseqalignmultipleModel::max(self : BioseqalignmultipleModel) -> Double { @_common.max(self.data) }

pub fn BioseqalignmultipleModel::to_string(self : BioseqalignmultipleModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_layer_make(size : Int) -> BioseqalignmultipleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignmultipleLayer::len(self : BioseqalignmultipleLayer) -> Int { self.size }

pub fn BioseqalignmultipleLayer::get(self : BioseqalignmultipleLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignmultipleLayer::set(self : BioseqalignmultipleLayer, i : Int, v : Double) -> BioseqalignmultipleLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleLayer::sum(self : BioseqalignmultipleLayer) -> Double { @_common.sum(self.data) }

pub fn BioseqalignmultipleLayer::mean(self : BioseqalignmultipleLayer) -> Double { @_common.mean(self.data) }

pub fn BioseqalignmultipleLayer::scale(self : BioseqalignmultipleLayer, f : Double) -> BioseqalignmultipleLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleLayer::add(self : BioseqalignmultipleLayer, other : BioseqalignmultipleLayer) -> BioseqalignmultipleLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignmultipleLayer::copy(self : BioseqalignmultipleLayer) -> BioseqalignmultipleLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleLayer::fill(self : BioseqalignmultipleLayer, v : Double) -> BioseqalignmultipleLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleLayer::min(self : BioseqalignmultipleLayer) -> Double { @_common.min(self.data) }

pub fn BioseqalignmultipleLayer::max(self : BioseqalignmultipleLayer) -> Double { @_common.max(self.data) }

pub fn BioseqalignmultipleLayer::to_string(self : BioseqalignmultipleLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_buffer_make(size : Int) -> BioseqalignmultipleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignmultipleBuffer::len(self : BioseqalignmultipleBuffer) -> Int { self.size }

pub fn BioseqalignmultipleBuffer::get(self : BioseqalignmultipleBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignmultipleBuffer::set(self : BioseqalignmultipleBuffer, i : Int, v : Double) -> BioseqalignmultipleBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleBuffer::sum(self : BioseqalignmultipleBuffer) -> Double { @_common.sum(self.data) }

pub fn BioseqalignmultipleBuffer::mean(self : BioseqalignmultipleBuffer) -> Double { @_common.mean(self.data) }

pub fn BioseqalignmultipleBuffer::scale(self : BioseqalignmultipleBuffer, f : Double) -> BioseqalignmultipleBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleBuffer::add(self : BioseqalignmultipleBuffer, other : BioseqalignmultipleBuffer) -> BioseqalignmultipleBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignmultipleBuffer::copy(self : BioseqalignmultipleBuffer) -> BioseqalignmultipleBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleBuffer::fill(self : BioseqalignmultipleBuffer, v : Double) -> BioseqalignmultipleBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleBuffer::min(self : BioseqalignmultipleBuffer) -> Double { @_common.min(self.data) }

pub fn BioseqalignmultipleBuffer::max(self : BioseqalignmultipleBuffer) -> Double { @_common.max(self.data) }

pub fn BioseqalignmultipleBuffer::to_string(self : BioseqalignmultipleBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_cursor_make(size : Int) -> BioseqalignmultipleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignmultipleCursor::len(self : BioseqalignmultipleCursor) -> Int { self.size }

pub fn BioseqalignmultipleCursor::get(self : BioseqalignmultipleCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignmultipleCursor::set(self : BioseqalignmultipleCursor, i : Int, v : Double) -> BioseqalignmultipleCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleCursor::sum(self : BioseqalignmultipleCursor) -> Double { @_common.sum(self.data) }

pub fn BioseqalignmultipleCursor::mean(self : BioseqalignmultipleCursor) -> Double { @_common.mean(self.data) }

pub fn BioseqalignmultipleCursor::scale(self : BioseqalignmultipleCursor, f : Double) -> BioseqalignmultipleCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleCursor::add(self : BioseqalignmultipleCursor, other : BioseqalignmultipleCursor) -> BioseqalignmultipleCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignmultipleCursor::copy(self : BioseqalignmultipleCursor) -> BioseqalignmultipleCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleCursor::fill(self : BioseqalignmultipleCursor, v : Double) -> BioseqalignmultipleCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleCursor::min(self : BioseqalignmultipleCursor) -> Double { @_common.min(self.data) }

pub fn BioseqalignmultipleCursor::max(self : BioseqalignmultipleCursor) -> Double { @_common.max(self.data) }

pub fn BioseqalignmultipleCursor::to_string(self : BioseqalignmultipleCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_view_make(size : Int) -> BioseqalignmultipleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignmultipleView::len(self : BioseqalignmultipleView) -> Int { self.size }

pub fn BioseqalignmultipleView::get(self : BioseqalignmultipleView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignmultipleView::set(self : BioseqalignmultipleView, i : Int, v : Double) -> BioseqalignmultipleView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleView::sum(self : BioseqalignmultipleView) -> Double { @_common.sum(self.data) }

pub fn BioseqalignmultipleView::mean(self : BioseqalignmultipleView) -> Double { @_common.mean(self.data) }

pub fn BioseqalignmultipleView::scale(self : BioseqalignmultipleView, f : Double) -> BioseqalignmultipleView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleView::add(self : BioseqalignmultipleView, other : BioseqalignmultipleView) -> BioseqalignmultipleView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignmultipleView::copy(self : BioseqalignmultipleView) -> BioseqalignmultipleView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleView::fill(self : BioseqalignmultipleView, v : Double) -> BioseqalignmultipleView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleView::min(self : BioseqalignmultipleView) -> Double { @_common.min(self.data) }

pub fn BioseqalignmultipleView::max(self : BioseqalignmultipleView) -> Double { @_common.max(self.data) }

pub fn BioseqalignmultipleView::to_string(self : BioseqalignmultipleView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_range_make(size : Int) -> BioseqalignmultipleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignmultipleRange::len(self : BioseqalignmultipleRange) -> Int { self.size }

pub fn BioseqalignmultipleRange::get(self : BioseqalignmultipleRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignmultipleRange::set(self : BioseqalignmultipleRange, i : Int, v : Double) -> BioseqalignmultipleRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleRange::sum(self : BioseqalignmultipleRange) -> Double { @_common.sum(self.data) }

pub fn BioseqalignmultipleRange::mean(self : BioseqalignmultipleRange) -> Double { @_common.mean(self.data) }

pub fn BioseqalignmultipleRange::scale(self : BioseqalignmultipleRange, f : Double) -> BioseqalignmultipleRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleRange::add(self : BioseqalignmultipleRange, other : BioseqalignmultipleRange) -> BioseqalignmultipleRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignmultipleRange::copy(self : BioseqalignmultipleRange) -> BioseqalignmultipleRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleRange::fill(self : BioseqalignmultipleRange, v : Double) -> BioseqalignmultipleRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleRange::min(self : BioseqalignmultipleRange) -> Double { @_common.min(self.data) }

pub fn BioseqalignmultipleRange::max(self : BioseqalignmultipleRange) -> Double { @_common.max(self.data) }

pub fn BioseqalignmultipleRange::to_string(self : BioseqalignmultipleRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_slice_make(size : Int) -> BioseqalignmultipleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqalignmultipleSlice::len(self : BioseqalignmultipleSlice) -> Int { self.size }

pub fn BioseqalignmultipleSlice::get(self : BioseqalignmultipleSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqalignmultipleSlice::set(self : BioseqalignmultipleSlice, i : Int, v : Double) -> BioseqalignmultipleSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleSlice::sum(self : BioseqalignmultipleSlice) -> Double { @_common.sum(self.data) }

pub fn BioseqalignmultipleSlice::mean(self : BioseqalignmultipleSlice) -> Double { @_common.mean(self.data) }

pub fn BioseqalignmultipleSlice::scale(self : BioseqalignmultipleSlice, f : Double) -> BioseqalignmultipleSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleSlice::add(self : BioseqalignmultipleSlice, other : BioseqalignmultipleSlice) -> BioseqalignmultipleSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqalignmultipleSlice::copy(self : BioseqalignmultipleSlice) -> BioseqalignmultipleSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleSlice::fill(self : BioseqalignmultipleSlice, v : Double) -> BioseqalignmultipleSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqalignmultipleSlice::min(self : BioseqalignmultipleSlice) -> Double { @_common.min(self.data) }

pub fn BioseqalignmultipleSlice::max(self : BioseqalignmultipleSlice) -> Double { @_common.max(self.data) }

pub fn BioseqalignmultipleSlice::to_string(self : BioseqalignmultipleSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

