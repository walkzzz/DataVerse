///===
/// extcore/timeseries_decomp_beveridge

pub(all) struct TimeseriesdecompbeveridgePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_beveridge_make_point(x : Double, y : Double) -> TimeseriesdecompbeveridgePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_beveridge_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompbeveridgePoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesdecompbeveridgePoint::x(self : TimeseriesdecompbeveridgePoint) -> Double { self.x }

pub fn TimeseriesdecompbeveridgePoint::y(self : TimeseriesdecompbeveridgePoint) -> Double { self.y }

pub fn TimeseriesdecompbeveridgePoint::z(self : TimeseriesdecompbeveridgePoint) -> Double { self.z }

pub fn TimeseriesdecompbeveridgePoint::label(self : TimeseriesdecompbeveridgePoint) -> Int { self.label }

pub fn TimeseriesdecompbeveridgePoint::dist(self : TimeseriesdecompbeveridgePoint, other : TimeseriesdecompbeveridgePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesdecompbeveridgePoint::add(self : TimeseriesdecompbeveridgePoint, other : TimeseriesdecompbeveridgePoint) -> TimeseriesdecompbeveridgePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesdecompbeveridgePoint::sub(self : TimeseriesdecompbeveridgePoint, other : TimeseriesdecompbeveridgePoint) -> TimeseriesdecompbeveridgePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesdecompbeveridgePoint::scale(self : TimeseriesdecompbeveridgePoint, s : Double) -> TimeseriesdecompbeveridgePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesdecompbeveridgePoint::dot(self : TimeseriesdecompbeveridgePoint, other : TimeseriesdecompbeveridgePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesdecompbeveridgePoint::cross(self : TimeseriesdecompbeveridgePoint, other : TimeseriesdecompbeveridgePoint) -> TimeseriesdecompbeveridgePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesdecompbeveridgePoint::norm(self : TimeseriesdecompbeveridgePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesdecompbeveridgePoint::normalize(self : TimeseriesdecompbeveridgePoint) -> TimeseriesdecompbeveridgePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompbeveridgePoint::negate(self : TimeseriesdecompbeveridgePoint) -> TimeseriesdecompbeveridgePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesdecompbeveridgePoint::mid(self : TimeseriesdecompbeveridgePoint, other : TimeseriesdecompbeveridgePoint) -> TimeseriesdecompbeveridgePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesdecompbeveridgePoint::lerp(self : TimeseriesdecompbeveridgePoint, other : TimeseriesdecompbeveridgePoint, t : Double) -> TimeseriesdecompbeveridgePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesdecompbeveridgePoint::to_string(self : TimeseriesdecompbeveridgePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_beveridge_make_series(vals : Array[Double], name : String) -> TimeseriesdecompbeveridgeSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesdecompbeveridgeSeries::len(self : TimeseriesdecompbeveridgeSeries) -> Int { self.vals.length() }

pub fn TimeseriesdecompbeveridgeSeries::sum(self : TimeseriesdecompbeveridgeSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesdecompbeveridgeSeries::mean(self : TimeseriesdecompbeveridgeSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesdecompbeveridgeSeries::min(self : TimeseriesdecompbeveridgeSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesdecompbeveridgeSeries::max(self : TimeseriesdecompbeveridgeSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesdecompbeveridgeSeries::range(self : TimeseriesdecompbeveridgeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesdecompbeveridgeSeries::variance(self : TimeseriesdecompbeveridgeSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesdecompbeveridgeSeries::std(self : TimeseriesdecompbeveridgeSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesdecompbeveridgeSeries::median(self : TimeseriesdecompbeveridgeSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesdecompbeveridgeSeries::scale(self : TimeseriesdecompbeveridgeSeries, f : Double) -> TimeseriesdecompbeveridgeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesdecompbeveridgeSeries::add(self : TimeseriesdecompbeveridgeSeries, other : TimeseriesdecompbeveridgeSeries) -> TimeseriesdecompbeveridgeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompbeveridgeSeries::sub(self : TimeseriesdecompbeveridgeSeries, other : TimeseriesdecompbeveridgeSeries) -> TimeseriesdecompbeveridgeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompbeveridgeSeries::normalize(self : TimeseriesdecompbeveridgeSeries) -> TimeseriesdecompbeveridgeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesdecompbeveridgeSeries::cumsum(self : TimeseriesdecompbeveridgeSeries) -> TimeseriesdecompbeveridgeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesdecompbeveridgeSeries::to_string(self : TimeseriesdecompbeveridgeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompbeveridgeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_beveridge_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompbeveridgeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_beveridge_matrix_identity(n : Int) -> TimeseriesdecompbeveridgeMatrix {
  let m = timeseries_decomp_beveridge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesdecompbeveridgeMatrix::get(self : TimeseriesdecompbeveridgeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesdecompbeveridgeMatrix::transpose(self : TimeseriesdecompbeveridgeMatrix) -> TimeseriesdecompbeveridgeMatrix {
  let result = timeseries_decomp_beveridge_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesdecompbeveridgeMatrix::add(self : TimeseriesdecompbeveridgeMatrix, other : TimeseriesdecompbeveridgeMatrix) -> TimeseriesdecompbeveridgeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_decomp_beveridge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesdecompbeveridgeMatrix::scale(self : TimeseriesdecompbeveridgeMatrix, s : Double) -> TimeseriesdecompbeveridgeMatrix {
  let result = timeseries_decomp_beveridge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesdecompbeveridgeMatrix::multiply(self : TimeseriesdecompbeveridgeMatrix, other : TimeseriesdecompbeveridgeMatrix) -> TimeseriesdecompbeveridgeMatrix {
  if self.cols != other.rows { return timeseries_decomp_beveridge_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_decomp_beveridge_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn TimeseriesdecompbeveridgeMatrix::trace(self : TimeseriesdecompbeveridgeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesdecompbeveridgeMatrix::det(self : TimeseriesdecompbeveridgeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesdecompbeveridgeMatrix::norm(self : TimeseriesdecompbeveridgeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesdecompbeveridgeMatrix::to_string(self : TimeseriesdecompbeveridgeMatrix) -> String {
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

pub(all) struct TimeseriesdecompbeveridgeVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_beveridge_make_vector(comps : Array[Double]) -> TimeseriesdecompbeveridgeVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_beveridge_vector_zero(dim : Int) -> TimeseriesdecompbeveridgeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesdecompbeveridgeVector::add(self : TimeseriesdecompbeveridgeVector, other : TimeseriesdecompbeveridgeVector) -> TimeseriesdecompbeveridgeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompbeveridgeVector::sub(self : TimeseriesdecompbeveridgeVector, other : TimeseriesdecompbeveridgeVector) -> TimeseriesdecompbeveridgeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompbeveridgeVector::scale(self : TimeseriesdecompbeveridgeVector, s : Double) -> TimeseriesdecompbeveridgeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesdecompbeveridgeVector::dot(self : TimeseriesdecompbeveridgeVector, other : TimeseriesdecompbeveridgeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesdecompbeveridgeVector::norm(self : TimeseriesdecompbeveridgeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesdecompbeveridgeVector::normalize(self : TimeseriesdecompbeveridgeVector) -> TimeseriesdecompbeveridgeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompbeveridgeVector::dist(self : TimeseriesdecompbeveridgeVector, other : TimeseriesdecompbeveridgeVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesdecompbeveridgeVector::to_string(self : TimeseriesdecompbeveridgeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompbeveridgeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_frame_make(size : Int) -> TimeseriesdecompbeveridgeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompbeveridgeFrame::len(self : TimeseriesdecompbeveridgeFrame) -> Int { self.size }

pub fn TimeseriesdecompbeveridgeFrame::get(self : TimeseriesdecompbeveridgeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompbeveridgeFrame::set(self : TimeseriesdecompbeveridgeFrame, i : Int, v : Double) -> TimeseriesdecompbeveridgeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeFrame::sum(self : TimeseriesdecompbeveridgeFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompbeveridgeFrame::mean(self : TimeseriesdecompbeveridgeFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompbeveridgeFrame::scale(self : TimeseriesdecompbeveridgeFrame, f : Double) -> TimeseriesdecompbeveridgeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeFrame::add(self : TimeseriesdecompbeveridgeFrame, other : TimeseriesdecompbeveridgeFrame) -> TimeseriesdecompbeveridgeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeFrame::copy(self : TimeseriesdecompbeveridgeFrame) -> TimeseriesdecompbeveridgeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeFrame::fill(self : TimeseriesdecompbeveridgeFrame, v : Double) -> TimeseriesdecompbeveridgeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeFrame::min(self : TimeseriesdecompbeveridgeFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompbeveridgeFrame::max(self : TimeseriesdecompbeveridgeFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompbeveridgeFrame::to_string(self : TimeseriesdecompbeveridgeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_table_make(size : Int) -> TimeseriesdecompbeveridgeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompbeveridgeTable::len(self : TimeseriesdecompbeveridgeTable) -> Int { self.size }

pub fn TimeseriesdecompbeveridgeTable::get(self : TimeseriesdecompbeveridgeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompbeveridgeTable::set(self : TimeseriesdecompbeveridgeTable, i : Int, v : Double) -> TimeseriesdecompbeveridgeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeTable::sum(self : TimeseriesdecompbeveridgeTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompbeveridgeTable::mean(self : TimeseriesdecompbeveridgeTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompbeveridgeTable::scale(self : TimeseriesdecompbeveridgeTable, f : Double) -> TimeseriesdecompbeveridgeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeTable::add(self : TimeseriesdecompbeveridgeTable, other : TimeseriesdecompbeveridgeTable) -> TimeseriesdecompbeveridgeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeTable::copy(self : TimeseriesdecompbeveridgeTable) -> TimeseriesdecompbeveridgeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeTable::fill(self : TimeseriesdecompbeveridgeTable, v : Double) -> TimeseriesdecompbeveridgeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeTable::min(self : TimeseriesdecompbeveridgeTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompbeveridgeTable::max(self : TimeseriesdecompbeveridgeTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompbeveridgeTable::to_string(self : TimeseriesdecompbeveridgeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_graphn_make(size : Int) -> TimeseriesdecompbeveridgeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompbeveridgeGraphN::len(self : TimeseriesdecompbeveridgeGraphN) -> Int { self.size }

pub fn TimeseriesdecompbeveridgeGraphN::get(self : TimeseriesdecompbeveridgeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompbeveridgeGraphN::set(self : TimeseriesdecompbeveridgeGraphN, i : Int, v : Double) -> TimeseriesdecompbeveridgeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeGraphN::sum(self : TimeseriesdecompbeveridgeGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompbeveridgeGraphN::mean(self : TimeseriesdecompbeveridgeGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompbeveridgeGraphN::scale(self : TimeseriesdecompbeveridgeGraphN, f : Double) -> TimeseriesdecompbeveridgeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeGraphN::add(self : TimeseriesdecompbeveridgeGraphN, other : TimeseriesdecompbeveridgeGraphN) -> TimeseriesdecompbeveridgeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeGraphN::copy(self : TimeseriesdecompbeveridgeGraphN) -> TimeseriesdecompbeveridgeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeGraphN::fill(self : TimeseriesdecompbeveridgeGraphN, v : Double) -> TimeseriesdecompbeveridgeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeGraphN::min(self : TimeseriesdecompbeveridgeGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompbeveridgeGraphN::max(self : TimeseriesdecompbeveridgeGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompbeveridgeGraphN::to_string(self : TimeseriesdecompbeveridgeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_node_make(size : Int) -> TimeseriesdecompbeveridgeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompbeveridgeNode::len(self : TimeseriesdecompbeveridgeNode) -> Int { self.size }

pub fn TimeseriesdecompbeveridgeNode::get(self : TimeseriesdecompbeveridgeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompbeveridgeNode::set(self : TimeseriesdecompbeveridgeNode, i : Int, v : Double) -> TimeseriesdecompbeveridgeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeNode::sum(self : TimeseriesdecompbeveridgeNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompbeveridgeNode::mean(self : TimeseriesdecompbeveridgeNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompbeveridgeNode::scale(self : TimeseriesdecompbeveridgeNode, f : Double) -> TimeseriesdecompbeveridgeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeNode::add(self : TimeseriesdecompbeveridgeNode, other : TimeseriesdecompbeveridgeNode) -> TimeseriesdecompbeveridgeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeNode::copy(self : TimeseriesdecompbeveridgeNode) -> TimeseriesdecompbeveridgeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeNode::fill(self : TimeseriesdecompbeveridgeNode, v : Double) -> TimeseriesdecompbeveridgeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeNode::min(self : TimeseriesdecompbeveridgeNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompbeveridgeNode::max(self : TimeseriesdecompbeveridgeNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompbeveridgeNode::to_string(self : TimeseriesdecompbeveridgeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_edge_make(size : Int) -> TimeseriesdecompbeveridgeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompbeveridgeEdge::len(self : TimeseriesdecompbeveridgeEdge) -> Int { self.size }

pub fn TimeseriesdecompbeveridgeEdge::get(self : TimeseriesdecompbeveridgeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompbeveridgeEdge::set(self : TimeseriesdecompbeveridgeEdge, i : Int, v : Double) -> TimeseriesdecompbeveridgeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeEdge::sum(self : TimeseriesdecompbeveridgeEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompbeveridgeEdge::mean(self : TimeseriesdecompbeveridgeEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompbeveridgeEdge::scale(self : TimeseriesdecompbeveridgeEdge, f : Double) -> TimeseriesdecompbeveridgeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeEdge::add(self : TimeseriesdecompbeveridgeEdge, other : TimeseriesdecompbeveridgeEdge) -> TimeseriesdecompbeveridgeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeEdge::copy(self : TimeseriesdecompbeveridgeEdge) -> TimeseriesdecompbeveridgeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeEdge::fill(self : TimeseriesdecompbeveridgeEdge, v : Double) -> TimeseriesdecompbeveridgeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeEdge::min(self : TimeseriesdecompbeveridgeEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompbeveridgeEdge::max(self : TimeseriesdecompbeveridgeEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompbeveridgeEdge::to_string(self : TimeseriesdecompbeveridgeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_path_make(size : Int) -> TimeseriesdecompbeveridgePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompbeveridgePath::len(self : TimeseriesdecompbeveridgePath) -> Int { self.size }

pub fn TimeseriesdecompbeveridgePath::get(self : TimeseriesdecompbeveridgePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompbeveridgePath::set(self : TimeseriesdecompbeveridgePath, i : Int, v : Double) -> TimeseriesdecompbeveridgePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgePath::sum(self : TimeseriesdecompbeveridgePath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompbeveridgePath::mean(self : TimeseriesdecompbeveridgePath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompbeveridgePath::scale(self : TimeseriesdecompbeveridgePath, f : Double) -> TimeseriesdecompbeveridgePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgePath::add(self : TimeseriesdecompbeveridgePath, other : TimeseriesdecompbeveridgePath) -> TimeseriesdecompbeveridgePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgePath::copy(self : TimeseriesdecompbeveridgePath) -> TimeseriesdecompbeveridgePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgePath::fill(self : TimeseriesdecompbeveridgePath, v : Double) -> TimeseriesdecompbeveridgePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgePath::min(self : TimeseriesdecompbeveridgePath) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompbeveridgePath::max(self : TimeseriesdecompbeveridgePath) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompbeveridgePath::to_string(self : TimeseriesdecompbeveridgePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_cluster_make(size : Int) -> TimeseriesdecompbeveridgeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompbeveridgeCluster::len(self : TimeseriesdecompbeveridgeCluster) -> Int { self.size }

pub fn TimeseriesdecompbeveridgeCluster::get(self : TimeseriesdecompbeveridgeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompbeveridgeCluster::set(self : TimeseriesdecompbeveridgeCluster, i : Int, v : Double) -> TimeseriesdecompbeveridgeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeCluster::sum(self : TimeseriesdecompbeveridgeCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompbeveridgeCluster::mean(self : TimeseriesdecompbeveridgeCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompbeveridgeCluster::scale(self : TimeseriesdecompbeveridgeCluster, f : Double) -> TimeseriesdecompbeveridgeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeCluster::add(self : TimeseriesdecompbeveridgeCluster, other : TimeseriesdecompbeveridgeCluster) -> TimeseriesdecompbeveridgeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeCluster::copy(self : TimeseriesdecompbeveridgeCluster) -> TimeseriesdecompbeveridgeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeCluster::fill(self : TimeseriesdecompbeveridgeCluster, v : Double) -> TimeseriesdecompbeveridgeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeCluster::min(self : TimeseriesdecompbeveridgeCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompbeveridgeCluster::max(self : TimeseriesdecompbeveridgeCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompbeveridgeCluster::to_string(self : TimeseriesdecompbeveridgeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_model_make(size : Int) -> TimeseriesdecompbeveridgeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompbeveridgeModel::len(self : TimeseriesdecompbeveridgeModel) -> Int { self.size }

pub fn TimeseriesdecompbeveridgeModel::get(self : TimeseriesdecompbeveridgeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompbeveridgeModel::set(self : TimeseriesdecompbeveridgeModel, i : Int, v : Double) -> TimeseriesdecompbeveridgeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeModel::sum(self : TimeseriesdecompbeveridgeModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompbeveridgeModel::mean(self : TimeseriesdecompbeveridgeModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompbeveridgeModel::scale(self : TimeseriesdecompbeveridgeModel, f : Double) -> TimeseriesdecompbeveridgeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeModel::add(self : TimeseriesdecompbeveridgeModel, other : TimeseriesdecompbeveridgeModel) -> TimeseriesdecompbeveridgeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeModel::copy(self : TimeseriesdecompbeveridgeModel) -> TimeseriesdecompbeveridgeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeModel::fill(self : TimeseriesdecompbeveridgeModel, v : Double) -> TimeseriesdecompbeveridgeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeModel::min(self : TimeseriesdecompbeveridgeModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompbeveridgeModel::max(self : TimeseriesdecompbeveridgeModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompbeveridgeModel::to_string(self : TimeseriesdecompbeveridgeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_layer_make(size : Int) -> TimeseriesdecompbeveridgeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompbeveridgeLayer::len(self : TimeseriesdecompbeveridgeLayer) -> Int { self.size }

pub fn TimeseriesdecompbeveridgeLayer::get(self : TimeseriesdecompbeveridgeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompbeveridgeLayer::set(self : TimeseriesdecompbeveridgeLayer, i : Int, v : Double) -> TimeseriesdecompbeveridgeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeLayer::sum(self : TimeseriesdecompbeveridgeLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompbeveridgeLayer::mean(self : TimeseriesdecompbeveridgeLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompbeveridgeLayer::scale(self : TimeseriesdecompbeveridgeLayer, f : Double) -> TimeseriesdecompbeveridgeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeLayer::add(self : TimeseriesdecompbeveridgeLayer, other : TimeseriesdecompbeveridgeLayer) -> TimeseriesdecompbeveridgeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeLayer::copy(self : TimeseriesdecompbeveridgeLayer) -> TimeseriesdecompbeveridgeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeLayer::fill(self : TimeseriesdecompbeveridgeLayer, v : Double) -> TimeseriesdecompbeveridgeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeLayer::min(self : TimeseriesdecompbeveridgeLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompbeveridgeLayer::max(self : TimeseriesdecompbeveridgeLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompbeveridgeLayer::to_string(self : TimeseriesdecompbeveridgeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_buffer_make(size : Int) -> TimeseriesdecompbeveridgeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompbeveridgeBuffer::len(self : TimeseriesdecompbeveridgeBuffer) -> Int { self.size }

pub fn TimeseriesdecompbeveridgeBuffer::get(self : TimeseriesdecompbeveridgeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompbeveridgeBuffer::set(self : TimeseriesdecompbeveridgeBuffer, i : Int, v : Double) -> TimeseriesdecompbeveridgeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeBuffer::sum(self : TimeseriesdecompbeveridgeBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompbeveridgeBuffer::mean(self : TimeseriesdecompbeveridgeBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompbeveridgeBuffer::scale(self : TimeseriesdecompbeveridgeBuffer, f : Double) -> TimeseriesdecompbeveridgeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeBuffer::add(self : TimeseriesdecompbeveridgeBuffer, other : TimeseriesdecompbeveridgeBuffer) -> TimeseriesdecompbeveridgeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeBuffer::copy(self : TimeseriesdecompbeveridgeBuffer) -> TimeseriesdecompbeveridgeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeBuffer::fill(self : TimeseriesdecompbeveridgeBuffer, v : Double) -> TimeseriesdecompbeveridgeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeBuffer::min(self : TimeseriesdecompbeveridgeBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompbeveridgeBuffer::max(self : TimeseriesdecompbeveridgeBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompbeveridgeBuffer::to_string(self : TimeseriesdecompbeveridgeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_cursor_make(size : Int) -> TimeseriesdecompbeveridgeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompbeveridgeCursor::len(self : TimeseriesdecompbeveridgeCursor) -> Int { self.size }

pub fn TimeseriesdecompbeveridgeCursor::get(self : TimeseriesdecompbeveridgeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompbeveridgeCursor::set(self : TimeseriesdecompbeveridgeCursor, i : Int, v : Double) -> TimeseriesdecompbeveridgeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeCursor::sum(self : TimeseriesdecompbeveridgeCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompbeveridgeCursor::mean(self : TimeseriesdecompbeveridgeCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompbeveridgeCursor::scale(self : TimeseriesdecompbeveridgeCursor, f : Double) -> TimeseriesdecompbeveridgeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeCursor::add(self : TimeseriesdecompbeveridgeCursor, other : TimeseriesdecompbeveridgeCursor) -> TimeseriesdecompbeveridgeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeCursor::copy(self : TimeseriesdecompbeveridgeCursor) -> TimeseriesdecompbeveridgeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeCursor::fill(self : TimeseriesdecompbeveridgeCursor, v : Double) -> TimeseriesdecompbeveridgeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeCursor::min(self : TimeseriesdecompbeveridgeCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompbeveridgeCursor::max(self : TimeseriesdecompbeveridgeCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompbeveridgeCursor::to_string(self : TimeseriesdecompbeveridgeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_view_make(size : Int) -> TimeseriesdecompbeveridgeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompbeveridgeView::len(self : TimeseriesdecompbeveridgeView) -> Int { self.size }

pub fn TimeseriesdecompbeveridgeView::get(self : TimeseriesdecompbeveridgeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompbeveridgeView::set(self : TimeseriesdecompbeveridgeView, i : Int, v : Double) -> TimeseriesdecompbeveridgeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeView::sum(self : TimeseriesdecompbeveridgeView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompbeveridgeView::mean(self : TimeseriesdecompbeveridgeView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompbeveridgeView::scale(self : TimeseriesdecompbeveridgeView, f : Double) -> TimeseriesdecompbeveridgeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeView::add(self : TimeseriesdecompbeveridgeView, other : TimeseriesdecompbeveridgeView) -> TimeseriesdecompbeveridgeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeView::copy(self : TimeseriesdecompbeveridgeView) -> TimeseriesdecompbeveridgeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeView::fill(self : TimeseriesdecompbeveridgeView, v : Double) -> TimeseriesdecompbeveridgeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeView::min(self : TimeseriesdecompbeveridgeView) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompbeveridgeView::max(self : TimeseriesdecompbeveridgeView) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompbeveridgeView::to_string(self : TimeseriesdecompbeveridgeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_range_make(size : Int) -> TimeseriesdecompbeveridgeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompbeveridgeRange::len(self : TimeseriesdecompbeveridgeRange) -> Int { self.size }

pub fn TimeseriesdecompbeveridgeRange::get(self : TimeseriesdecompbeveridgeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompbeveridgeRange::set(self : TimeseriesdecompbeveridgeRange, i : Int, v : Double) -> TimeseriesdecompbeveridgeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeRange::sum(self : TimeseriesdecompbeveridgeRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompbeveridgeRange::mean(self : TimeseriesdecompbeveridgeRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompbeveridgeRange::scale(self : TimeseriesdecompbeveridgeRange, f : Double) -> TimeseriesdecompbeveridgeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeRange::add(self : TimeseriesdecompbeveridgeRange, other : TimeseriesdecompbeveridgeRange) -> TimeseriesdecompbeveridgeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeRange::copy(self : TimeseriesdecompbeveridgeRange) -> TimeseriesdecompbeveridgeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeRange::fill(self : TimeseriesdecompbeveridgeRange, v : Double) -> TimeseriesdecompbeveridgeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeRange::min(self : TimeseriesdecompbeveridgeRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompbeveridgeRange::max(self : TimeseriesdecompbeveridgeRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompbeveridgeRange::to_string(self : TimeseriesdecompbeveridgeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_slice_make(size : Int) -> TimeseriesdecompbeveridgeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompbeveridgeSlice::len(self : TimeseriesdecompbeveridgeSlice) -> Int { self.size }

pub fn TimeseriesdecompbeveridgeSlice::get(self : TimeseriesdecompbeveridgeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompbeveridgeSlice::set(self : TimeseriesdecompbeveridgeSlice, i : Int, v : Double) -> TimeseriesdecompbeveridgeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeSlice::sum(self : TimeseriesdecompbeveridgeSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompbeveridgeSlice::mean(self : TimeseriesdecompbeveridgeSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompbeveridgeSlice::scale(self : TimeseriesdecompbeveridgeSlice, f : Double) -> TimeseriesdecompbeveridgeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeSlice::add(self : TimeseriesdecompbeveridgeSlice, other : TimeseriesdecompbeveridgeSlice) -> TimeseriesdecompbeveridgeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeSlice::copy(self : TimeseriesdecompbeveridgeSlice) -> TimeseriesdecompbeveridgeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeSlice::fill(self : TimeseriesdecompbeveridgeSlice, v : Double) -> TimeseriesdecompbeveridgeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompbeveridgeSlice::min(self : TimeseriesdecompbeveridgeSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompbeveridgeSlice::max(self : TimeseriesdecompbeveridgeSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompbeveridgeSlice::to_string(self : TimeseriesdecompbeveridgeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

