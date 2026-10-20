///===
/// extcore/ds_heap_fibonacci

pub(all) struct DsheapfibonacciPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_fibonacci_make_point(x : Double, y : Double) -> DsheapfibonacciPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_fibonacci_make_point3(x : Double, y : Double, z : Double) -> DsheapfibonacciPoint {
  { x, y, z, label: 0 }
}

pub fn DsheapfibonacciPoint::x(self : DsheapfibonacciPoint) -> Double { self.x }

pub fn DsheapfibonacciPoint::y(self : DsheapfibonacciPoint) -> Double { self.y }

pub fn DsheapfibonacciPoint::z(self : DsheapfibonacciPoint) -> Double { self.z }

pub fn DsheapfibonacciPoint::label(self : DsheapfibonacciPoint) -> Int { self.label }

pub fn DsheapfibonacciPoint::dist(self : DsheapfibonacciPoint, other : DsheapfibonacciPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsheapfibonacciPoint::add(self : DsheapfibonacciPoint, other : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsheapfibonacciPoint::sub(self : DsheapfibonacciPoint, other : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsheapfibonacciPoint::scale(self : DsheapfibonacciPoint, s : Double) -> DsheapfibonacciPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsheapfibonacciPoint::dot(self : DsheapfibonacciPoint, other : DsheapfibonacciPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsheapfibonacciPoint::cross(self : DsheapfibonacciPoint, other : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsheapfibonacciPoint::norm(self : DsheapfibonacciPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsheapfibonacciPoint::normalize(self : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapfibonacciPoint::negate(self : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsheapfibonacciPoint::mid(self : DsheapfibonacciPoint, other : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsheapfibonacciPoint::lerp(self : DsheapfibonacciPoint, other : DsheapfibonacciPoint, t : Double) -> DsheapfibonacciPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsheapfibonacciPoint::to_string(self : DsheapfibonacciPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsheapfibonacciSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_fibonacci_make_series(vals : Array[Double], name : String) -> DsheapfibonacciSeries {
  { vals, name, meta: 0 }
}

pub fn DsheapfibonacciSeries::len(self : DsheapfibonacciSeries) -> Int { self.vals.length() }

pub fn DsheapfibonacciSeries::sum(self : DsheapfibonacciSeries) -> Double { @_common.sum(self.vals) }

pub fn DsheapfibonacciSeries::mean(self : DsheapfibonacciSeries) -> Double { @_common.mean(self.vals) }

pub fn DsheapfibonacciSeries::min(self : DsheapfibonacciSeries) -> Double { @_common.min(self.vals) }

pub fn DsheapfibonacciSeries::max(self : DsheapfibonacciSeries) -> Double { @_common.max(self.vals) }

pub fn DsheapfibonacciSeries::range(self : DsheapfibonacciSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsheapfibonacciSeries::variance(self : DsheapfibonacciSeries) -> Double { @_common.variance(self.vals) }

pub fn DsheapfibonacciSeries::std(self : DsheapfibonacciSeries) -> Double { @_common.std(self.vals) }

pub fn DsheapfibonacciSeries::median(self : DsheapfibonacciSeries) -> Double { @_common.median(self.vals) }

pub fn DsheapfibonacciSeries::scale(self : DsheapfibonacciSeries, f : Double) -> DsheapfibonacciSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsheapfibonacciSeries::add(self : DsheapfibonacciSeries, other : DsheapfibonacciSeries) -> DsheapfibonacciSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsheapfibonacciSeries::sub(self : DsheapfibonacciSeries, other : DsheapfibonacciSeries) -> DsheapfibonacciSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsheapfibonacciSeries::normalize(self : DsheapfibonacciSeries) -> DsheapfibonacciSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsheapfibonacciSeries::cumsum(self : DsheapfibonacciSeries) -> DsheapfibonacciSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsheapfibonacciSeries::to_string(self : DsheapfibonacciSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapfibonacciMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_fibonacci_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapfibonacciMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ds_heap_fibonacci_matrix_identity(n : Int) -> DsheapfibonacciMatrix {
  let m = ds_heap_fibonacci_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsheapfibonacciMatrix::get(self : DsheapfibonacciMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsheapfibonacciMatrix::transpose(self : DsheapfibonacciMatrix) -> DsheapfibonacciMatrix {
  let result = ds_heap_fibonacci_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsheapfibonacciMatrix::add(self : DsheapfibonacciMatrix, other : DsheapfibonacciMatrix) -> DsheapfibonacciMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_heap_fibonacci_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsheapfibonacciMatrix::scale(self : DsheapfibonacciMatrix, s : Double) -> DsheapfibonacciMatrix {
  let result = ds_heap_fibonacci_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsheapfibonacciMatrix::multiply(self : DsheapfibonacciMatrix, other : DsheapfibonacciMatrix) -> DsheapfibonacciMatrix {
  if self.cols != other.rows { return ds_heap_fibonacci_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_heap_fibonacci_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DsheapfibonacciMatrix::trace(self : DsheapfibonacciMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsheapfibonacciMatrix::det(self : DsheapfibonacciMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsheapfibonacciMatrix::norm(self : DsheapfibonacciMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsheapfibonacciMatrix::to_string(self : DsheapfibonacciMatrix) -> String {
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

pub(all) struct DsheapfibonacciVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_fibonacci_make_vector(comps : Array[Double]) -> DsheapfibonacciVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_fibonacci_vector_zero(dim : Int) -> DsheapfibonacciVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsheapfibonacciVector::add(self : DsheapfibonacciVector, other : DsheapfibonacciVector) -> DsheapfibonacciVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapfibonacciVector::sub(self : DsheapfibonacciVector, other : DsheapfibonacciVector) -> DsheapfibonacciVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapfibonacciVector::scale(self : DsheapfibonacciVector, s : Double) -> DsheapfibonacciVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsheapfibonacciVector::dot(self : DsheapfibonacciVector, other : DsheapfibonacciVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsheapfibonacciVector::norm(self : DsheapfibonacciVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsheapfibonacciVector::normalize(self : DsheapfibonacciVector) -> DsheapfibonacciVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapfibonacciVector::dist(self : DsheapfibonacciVector, other : DsheapfibonacciVector) -> Double {
  self.sub(other).norm()
}

pub fn DsheapfibonacciVector::to_string(self : DsheapfibonacciVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapfibonacciFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_frame_make(size : Int) -> DsheapfibonacciFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapfibonacciFrame::len(self : DsheapfibonacciFrame) -> Int { self.size }

pub fn DsheapfibonacciFrame::get(self : DsheapfibonacciFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapfibonacciFrame::set(self : DsheapfibonacciFrame, i : Int, v : Double) -> DsheapfibonacciFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciFrame::sum(self : DsheapfibonacciFrame) -> Double { @_common.sum(self.data) }

pub fn DsheapfibonacciFrame::mean(self : DsheapfibonacciFrame) -> Double { @_common.mean(self.data) }

pub fn DsheapfibonacciFrame::scale(self : DsheapfibonacciFrame, f : Double) -> DsheapfibonacciFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciFrame::add(self : DsheapfibonacciFrame, other : DsheapfibonacciFrame) -> DsheapfibonacciFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapfibonacciFrame::copy(self : DsheapfibonacciFrame) -> DsheapfibonacciFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciFrame::fill(self : DsheapfibonacciFrame, v : Double) -> DsheapfibonacciFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciFrame::min(self : DsheapfibonacciFrame) -> Double { @_common.min(self.data) }

pub fn DsheapfibonacciFrame::max(self : DsheapfibonacciFrame) -> Double { @_common.max(self.data) }

pub fn DsheapfibonacciFrame::to_string(self : DsheapfibonacciFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_table_make(size : Int) -> DsheapfibonacciTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapfibonacciTable::len(self : DsheapfibonacciTable) -> Int { self.size }

pub fn DsheapfibonacciTable::get(self : DsheapfibonacciTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapfibonacciTable::set(self : DsheapfibonacciTable, i : Int, v : Double) -> DsheapfibonacciTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciTable::sum(self : DsheapfibonacciTable) -> Double { @_common.sum(self.data) }

pub fn DsheapfibonacciTable::mean(self : DsheapfibonacciTable) -> Double { @_common.mean(self.data) }

pub fn DsheapfibonacciTable::scale(self : DsheapfibonacciTable, f : Double) -> DsheapfibonacciTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciTable::add(self : DsheapfibonacciTable, other : DsheapfibonacciTable) -> DsheapfibonacciTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapfibonacciTable::copy(self : DsheapfibonacciTable) -> DsheapfibonacciTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciTable::fill(self : DsheapfibonacciTable, v : Double) -> DsheapfibonacciTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciTable::min(self : DsheapfibonacciTable) -> Double { @_common.min(self.data) }

pub fn DsheapfibonacciTable::max(self : DsheapfibonacciTable) -> Double { @_common.max(self.data) }

pub fn DsheapfibonacciTable::to_string(self : DsheapfibonacciTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_graphn_make(size : Int) -> DsheapfibonacciGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapfibonacciGraphN::len(self : DsheapfibonacciGraphN) -> Int { self.size }

pub fn DsheapfibonacciGraphN::get(self : DsheapfibonacciGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapfibonacciGraphN::set(self : DsheapfibonacciGraphN, i : Int, v : Double) -> DsheapfibonacciGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciGraphN::sum(self : DsheapfibonacciGraphN) -> Double { @_common.sum(self.data) }

pub fn DsheapfibonacciGraphN::mean(self : DsheapfibonacciGraphN) -> Double { @_common.mean(self.data) }

pub fn DsheapfibonacciGraphN::scale(self : DsheapfibonacciGraphN, f : Double) -> DsheapfibonacciGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciGraphN::add(self : DsheapfibonacciGraphN, other : DsheapfibonacciGraphN) -> DsheapfibonacciGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapfibonacciGraphN::copy(self : DsheapfibonacciGraphN) -> DsheapfibonacciGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciGraphN::fill(self : DsheapfibonacciGraphN, v : Double) -> DsheapfibonacciGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciGraphN::min(self : DsheapfibonacciGraphN) -> Double { @_common.min(self.data) }

pub fn DsheapfibonacciGraphN::max(self : DsheapfibonacciGraphN) -> Double { @_common.max(self.data) }

pub fn DsheapfibonacciGraphN::to_string(self : DsheapfibonacciGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_node_make(size : Int) -> DsheapfibonacciNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapfibonacciNode::len(self : DsheapfibonacciNode) -> Int { self.size }

pub fn DsheapfibonacciNode::get(self : DsheapfibonacciNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapfibonacciNode::set(self : DsheapfibonacciNode, i : Int, v : Double) -> DsheapfibonacciNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciNode::sum(self : DsheapfibonacciNode) -> Double { @_common.sum(self.data) }

pub fn DsheapfibonacciNode::mean(self : DsheapfibonacciNode) -> Double { @_common.mean(self.data) }

pub fn DsheapfibonacciNode::scale(self : DsheapfibonacciNode, f : Double) -> DsheapfibonacciNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciNode::add(self : DsheapfibonacciNode, other : DsheapfibonacciNode) -> DsheapfibonacciNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapfibonacciNode::copy(self : DsheapfibonacciNode) -> DsheapfibonacciNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciNode::fill(self : DsheapfibonacciNode, v : Double) -> DsheapfibonacciNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciNode::min(self : DsheapfibonacciNode) -> Double { @_common.min(self.data) }

pub fn DsheapfibonacciNode::max(self : DsheapfibonacciNode) -> Double { @_common.max(self.data) }

pub fn DsheapfibonacciNode::to_string(self : DsheapfibonacciNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_edge_make(size : Int) -> DsheapfibonacciEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapfibonacciEdge::len(self : DsheapfibonacciEdge) -> Int { self.size }

pub fn DsheapfibonacciEdge::get(self : DsheapfibonacciEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapfibonacciEdge::set(self : DsheapfibonacciEdge, i : Int, v : Double) -> DsheapfibonacciEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciEdge::sum(self : DsheapfibonacciEdge) -> Double { @_common.sum(self.data) }

pub fn DsheapfibonacciEdge::mean(self : DsheapfibonacciEdge) -> Double { @_common.mean(self.data) }

pub fn DsheapfibonacciEdge::scale(self : DsheapfibonacciEdge, f : Double) -> DsheapfibonacciEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciEdge::add(self : DsheapfibonacciEdge, other : DsheapfibonacciEdge) -> DsheapfibonacciEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapfibonacciEdge::copy(self : DsheapfibonacciEdge) -> DsheapfibonacciEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciEdge::fill(self : DsheapfibonacciEdge, v : Double) -> DsheapfibonacciEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciEdge::min(self : DsheapfibonacciEdge) -> Double { @_common.min(self.data) }

pub fn DsheapfibonacciEdge::max(self : DsheapfibonacciEdge) -> Double { @_common.max(self.data) }

pub fn DsheapfibonacciEdge::to_string(self : DsheapfibonacciEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_path_make(size : Int) -> DsheapfibonacciPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapfibonacciPath::len(self : DsheapfibonacciPath) -> Int { self.size }

pub fn DsheapfibonacciPath::get(self : DsheapfibonacciPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapfibonacciPath::set(self : DsheapfibonacciPath, i : Int, v : Double) -> DsheapfibonacciPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciPath::sum(self : DsheapfibonacciPath) -> Double { @_common.sum(self.data) }

pub fn DsheapfibonacciPath::mean(self : DsheapfibonacciPath) -> Double { @_common.mean(self.data) }

pub fn DsheapfibonacciPath::scale(self : DsheapfibonacciPath, f : Double) -> DsheapfibonacciPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciPath::add(self : DsheapfibonacciPath, other : DsheapfibonacciPath) -> DsheapfibonacciPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapfibonacciPath::copy(self : DsheapfibonacciPath) -> DsheapfibonacciPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciPath::fill(self : DsheapfibonacciPath, v : Double) -> DsheapfibonacciPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciPath::min(self : DsheapfibonacciPath) -> Double { @_common.min(self.data) }

pub fn DsheapfibonacciPath::max(self : DsheapfibonacciPath) -> Double { @_common.max(self.data) }

pub fn DsheapfibonacciPath::to_string(self : DsheapfibonacciPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_cluster_make(size : Int) -> DsheapfibonacciCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapfibonacciCluster::len(self : DsheapfibonacciCluster) -> Int { self.size }

pub fn DsheapfibonacciCluster::get(self : DsheapfibonacciCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapfibonacciCluster::set(self : DsheapfibonacciCluster, i : Int, v : Double) -> DsheapfibonacciCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciCluster::sum(self : DsheapfibonacciCluster) -> Double { @_common.sum(self.data) }

pub fn DsheapfibonacciCluster::mean(self : DsheapfibonacciCluster) -> Double { @_common.mean(self.data) }

pub fn DsheapfibonacciCluster::scale(self : DsheapfibonacciCluster, f : Double) -> DsheapfibonacciCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciCluster::add(self : DsheapfibonacciCluster, other : DsheapfibonacciCluster) -> DsheapfibonacciCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapfibonacciCluster::copy(self : DsheapfibonacciCluster) -> DsheapfibonacciCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciCluster::fill(self : DsheapfibonacciCluster, v : Double) -> DsheapfibonacciCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciCluster::min(self : DsheapfibonacciCluster) -> Double { @_common.min(self.data) }

pub fn DsheapfibonacciCluster::max(self : DsheapfibonacciCluster) -> Double { @_common.max(self.data) }

pub fn DsheapfibonacciCluster::to_string(self : DsheapfibonacciCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_model_make(size : Int) -> DsheapfibonacciModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapfibonacciModel::len(self : DsheapfibonacciModel) -> Int { self.size }

pub fn DsheapfibonacciModel::get(self : DsheapfibonacciModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapfibonacciModel::set(self : DsheapfibonacciModel, i : Int, v : Double) -> DsheapfibonacciModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciModel::sum(self : DsheapfibonacciModel) -> Double { @_common.sum(self.data) }

pub fn DsheapfibonacciModel::mean(self : DsheapfibonacciModel) -> Double { @_common.mean(self.data) }

pub fn DsheapfibonacciModel::scale(self : DsheapfibonacciModel, f : Double) -> DsheapfibonacciModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciModel::add(self : DsheapfibonacciModel, other : DsheapfibonacciModel) -> DsheapfibonacciModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapfibonacciModel::copy(self : DsheapfibonacciModel) -> DsheapfibonacciModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciModel::fill(self : DsheapfibonacciModel, v : Double) -> DsheapfibonacciModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciModel::min(self : DsheapfibonacciModel) -> Double { @_common.min(self.data) }

pub fn DsheapfibonacciModel::max(self : DsheapfibonacciModel) -> Double { @_common.max(self.data) }

pub fn DsheapfibonacciModel::to_string(self : DsheapfibonacciModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_layer_make(size : Int) -> DsheapfibonacciLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapfibonacciLayer::len(self : DsheapfibonacciLayer) -> Int { self.size }

pub fn DsheapfibonacciLayer::get(self : DsheapfibonacciLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapfibonacciLayer::set(self : DsheapfibonacciLayer, i : Int, v : Double) -> DsheapfibonacciLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciLayer::sum(self : DsheapfibonacciLayer) -> Double { @_common.sum(self.data) }

pub fn DsheapfibonacciLayer::mean(self : DsheapfibonacciLayer) -> Double { @_common.mean(self.data) }

pub fn DsheapfibonacciLayer::scale(self : DsheapfibonacciLayer, f : Double) -> DsheapfibonacciLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciLayer::add(self : DsheapfibonacciLayer, other : DsheapfibonacciLayer) -> DsheapfibonacciLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapfibonacciLayer::copy(self : DsheapfibonacciLayer) -> DsheapfibonacciLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciLayer::fill(self : DsheapfibonacciLayer, v : Double) -> DsheapfibonacciLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciLayer::min(self : DsheapfibonacciLayer) -> Double { @_common.min(self.data) }

pub fn DsheapfibonacciLayer::max(self : DsheapfibonacciLayer) -> Double { @_common.max(self.data) }

pub fn DsheapfibonacciLayer::to_string(self : DsheapfibonacciLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_buffer_make(size : Int) -> DsheapfibonacciBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapfibonacciBuffer::len(self : DsheapfibonacciBuffer) -> Int { self.size }

pub fn DsheapfibonacciBuffer::get(self : DsheapfibonacciBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapfibonacciBuffer::set(self : DsheapfibonacciBuffer, i : Int, v : Double) -> DsheapfibonacciBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciBuffer::sum(self : DsheapfibonacciBuffer) -> Double { @_common.sum(self.data) }

pub fn DsheapfibonacciBuffer::mean(self : DsheapfibonacciBuffer) -> Double { @_common.mean(self.data) }

pub fn DsheapfibonacciBuffer::scale(self : DsheapfibonacciBuffer, f : Double) -> DsheapfibonacciBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciBuffer::add(self : DsheapfibonacciBuffer, other : DsheapfibonacciBuffer) -> DsheapfibonacciBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapfibonacciBuffer::copy(self : DsheapfibonacciBuffer) -> DsheapfibonacciBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciBuffer::fill(self : DsheapfibonacciBuffer, v : Double) -> DsheapfibonacciBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciBuffer::min(self : DsheapfibonacciBuffer) -> Double { @_common.min(self.data) }

pub fn DsheapfibonacciBuffer::max(self : DsheapfibonacciBuffer) -> Double { @_common.max(self.data) }

pub fn DsheapfibonacciBuffer::to_string(self : DsheapfibonacciBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_cursor_make(size : Int) -> DsheapfibonacciCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapfibonacciCursor::len(self : DsheapfibonacciCursor) -> Int { self.size }

pub fn DsheapfibonacciCursor::get(self : DsheapfibonacciCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapfibonacciCursor::set(self : DsheapfibonacciCursor, i : Int, v : Double) -> DsheapfibonacciCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciCursor::sum(self : DsheapfibonacciCursor) -> Double { @_common.sum(self.data) }

pub fn DsheapfibonacciCursor::mean(self : DsheapfibonacciCursor) -> Double { @_common.mean(self.data) }

pub fn DsheapfibonacciCursor::scale(self : DsheapfibonacciCursor, f : Double) -> DsheapfibonacciCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciCursor::add(self : DsheapfibonacciCursor, other : DsheapfibonacciCursor) -> DsheapfibonacciCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapfibonacciCursor::copy(self : DsheapfibonacciCursor) -> DsheapfibonacciCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciCursor::fill(self : DsheapfibonacciCursor, v : Double) -> DsheapfibonacciCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciCursor::min(self : DsheapfibonacciCursor) -> Double { @_common.min(self.data) }

pub fn DsheapfibonacciCursor::max(self : DsheapfibonacciCursor) -> Double { @_common.max(self.data) }

pub fn DsheapfibonacciCursor::to_string(self : DsheapfibonacciCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_view_make(size : Int) -> DsheapfibonacciView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapfibonacciView::len(self : DsheapfibonacciView) -> Int { self.size }

pub fn DsheapfibonacciView::get(self : DsheapfibonacciView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapfibonacciView::set(self : DsheapfibonacciView, i : Int, v : Double) -> DsheapfibonacciView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciView::sum(self : DsheapfibonacciView) -> Double { @_common.sum(self.data) }

pub fn DsheapfibonacciView::mean(self : DsheapfibonacciView) -> Double { @_common.mean(self.data) }

pub fn DsheapfibonacciView::scale(self : DsheapfibonacciView, f : Double) -> DsheapfibonacciView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciView::add(self : DsheapfibonacciView, other : DsheapfibonacciView) -> DsheapfibonacciView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapfibonacciView::copy(self : DsheapfibonacciView) -> DsheapfibonacciView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciView::fill(self : DsheapfibonacciView, v : Double) -> DsheapfibonacciView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciView::min(self : DsheapfibonacciView) -> Double { @_common.min(self.data) }

pub fn DsheapfibonacciView::max(self : DsheapfibonacciView) -> Double { @_common.max(self.data) }

pub fn DsheapfibonacciView::to_string(self : DsheapfibonacciView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_range_make(size : Int) -> DsheapfibonacciRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapfibonacciRange::len(self : DsheapfibonacciRange) -> Int { self.size }

pub fn DsheapfibonacciRange::get(self : DsheapfibonacciRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapfibonacciRange::set(self : DsheapfibonacciRange, i : Int, v : Double) -> DsheapfibonacciRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciRange::sum(self : DsheapfibonacciRange) -> Double { @_common.sum(self.data) }

pub fn DsheapfibonacciRange::mean(self : DsheapfibonacciRange) -> Double { @_common.mean(self.data) }

pub fn DsheapfibonacciRange::scale(self : DsheapfibonacciRange, f : Double) -> DsheapfibonacciRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciRange::add(self : DsheapfibonacciRange, other : DsheapfibonacciRange) -> DsheapfibonacciRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapfibonacciRange::copy(self : DsheapfibonacciRange) -> DsheapfibonacciRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciRange::fill(self : DsheapfibonacciRange, v : Double) -> DsheapfibonacciRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciRange::min(self : DsheapfibonacciRange) -> Double { @_common.min(self.data) }

pub fn DsheapfibonacciRange::max(self : DsheapfibonacciRange) -> Double { @_common.max(self.data) }

pub fn DsheapfibonacciRange::to_string(self : DsheapfibonacciRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_slice_make(size : Int) -> DsheapfibonacciSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapfibonacciSlice::len(self : DsheapfibonacciSlice) -> Int { self.size }

pub fn DsheapfibonacciSlice::get(self : DsheapfibonacciSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapfibonacciSlice::set(self : DsheapfibonacciSlice, i : Int, v : Double) -> DsheapfibonacciSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciSlice::sum(self : DsheapfibonacciSlice) -> Double { @_common.sum(self.data) }

pub fn DsheapfibonacciSlice::mean(self : DsheapfibonacciSlice) -> Double { @_common.mean(self.data) }

pub fn DsheapfibonacciSlice::scale(self : DsheapfibonacciSlice, f : Double) -> DsheapfibonacciSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciSlice::add(self : DsheapfibonacciSlice, other : DsheapfibonacciSlice) -> DsheapfibonacciSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapfibonacciSlice::copy(self : DsheapfibonacciSlice) -> DsheapfibonacciSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciSlice::fill(self : DsheapfibonacciSlice, v : Double) -> DsheapfibonacciSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapfibonacciSlice::min(self : DsheapfibonacciSlice) -> Double { @_common.min(self.data) }

pub fn DsheapfibonacciSlice::max(self : DsheapfibonacciSlice) -> Double { @_common.max(self.data) }

pub fn DsheapfibonacciSlice::to_string(self : DsheapfibonacciSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

