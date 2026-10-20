///===
/// extcore/timeseries_forecast_comb

pub(all) struct TimeseriesforecastcombPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_comb_make_point(x : Double, y : Double) -> TimeseriesforecastcombPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_comb_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastcombPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesforecastcombPoint::x(self : TimeseriesforecastcombPoint) -> Double { self.x }

pub fn TimeseriesforecastcombPoint::y(self : TimeseriesforecastcombPoint) -> Double { self.y }

pub fn TimeseriesforecastcombPoint::z(self : TimeseriesforecastcombPoint) -> Double { self.z }

pub fn TimeseriesforecastcombPoint::label(self : TimeseriesforecastcombPoint) -> Int { self.label }

pub fn TimeseriesforecastcombPoint::dist(self : TimeseriesforecastcombPoint, other : TimeseriesforecastcombPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesforecastcombPoint::add(self : TimeseriesforecastcombPoint, other : TimeseriesforecastcombPoint) -> TimeseriesforecastcombPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesforecastcombPoint::sub(self : TimeseriesforecastcombPoint, other : TimeseriesforecastcombPoint) -> TimeseriesforecastcombPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesforecastcombPoint::scale(self : TimeseriesforecastcombPoint, s : Double) -> TimeseriesforecastcombPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesforecastcombPoint::dot(self : TimeseriesforecastcombPoint, other : TimeseriesforecastcombPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesforecastcombPoint::cross(self : TimeseriesforecastcombPoint, other : TimeseriesforecastcombPoint) -> TimeseriesforecastcombPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesforecastcombPoint::norm(self : TimeseriesforecastcombPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesforecastcombPoint::normalize(self : TimeseriesforecastcombPoint) -> TimeseriesforecastcombPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastcombPoint::negate(self : TimeseriesforecastcombPoint) -> TimeseriesforecastcombPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesforecastcombPoint::mid(self : TimeseriesforecastcombPoint, other : TimeseriesforecastcombPoint) -> TimeseriesforecastcombPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesforecastcombPoint::lerp(self : TimeseriesforecastcombPoint, other : TimeseriesforecastcombPoint, t : Double) -> TimeseriesforecastcombPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesforecastcombPoint::to_string(self : TimeseriesforecastcombPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_comb_make_series(vals : Array[Double], name : String) -> TimeseriesforecastcombSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesforecastcombSeries::len(self : TimeseriesforecastcombSeries) -> Int { self.vals.length() }

pub fn TimeseriesforecastcombSeries::sum(self : TimeseriesforecastcombSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesforecastcombSeries::mean(self : TimeseriesforecastcombSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesforecastcombSeries::min(self : TimeseriesforecastcombSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesforecastcombSeries::max(self : TimeseriesforecastcombSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesforecastcombSeries::range(self : TimeseriesforecastcombSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesforecastcombSeries::variance(self : TimeseriesforecastcombSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesforecastcombSeries::std(self : TimeseriesforecastcombSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesforecastcombSeries::median(self : TimeseriesforecastcombSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesforecastcombSeries::scale(self : TimeseriesforecastcombSeries, f : Double) -> TimeseriesforecastcombSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesforecastcombSeries::add(self : TimeseriesforecastcombSeries, other : TimeseriesforecastcombSeries) -> TimeseriesforecastcombSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastcombSeries::sub(self : TimeseriesforecastcombSeries, other : TimeseriesforecastcombSeries) -> TimeseriesforecastcombSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastcombSeries::normalize(self : TimeseriesforecastcombSeries) -> TimeseriesforecastcombSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesforecastcombSeries::cumsum(self : TimeseriesforecastcombSeries) -> TimeseriesforecastcombSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesforecastcombSeries::to_string(self : TimeseriesforecastcombSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastcombMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_comb_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastcombMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn timeseries_forecast_comb_matrix_identity(n : Int) -> TimeseriesforecastcombMatrix {
  let m = timeseries_forecast_comb_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesforecastcombMatrix::get(self : TimeseriesforecastcombMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesforecastcombMatrix::transpose(self : TimeseriesforecastcombMatrix) -> TimeseriesforecastcombMatrix {
  let result = timeseries_forecast_comb_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesforecastcombMatrix::add(self : TimeseriesforecastcombMatrix, other : TimeseriesforecastcombMatrix) -> TimeseriesforecastcombMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_forecast_comb_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesforecastcombMatrix::scale(self : TimeseriesforecastcombMatrix, s : Double) -> TimeseriesforecastcombMatrix {
  let result = timeseries_forecast_comb_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesforecastcombMatrix::multiply(self : TimeseriesforecastcombMatrix, other : TimeseriesforecastcombMatrix) -> TimeseriesforecastcombMatrix {
  if self.cols != other.rows { return timeseries_forecast_comb_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_forecast_comb_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn TimeseriesforecastcombMatrix::trace(self : TimeseriesforecastcombMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesforecastcombMatrix::det(self : TimeseriesforecastcombMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesforecastcombMatrix::norm(self : TimeseriesforecastcombMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesforecastcombMatrix::to_string(self : TimeseriesforecastcombMatrix) -> String {
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

pub(all) struct TimeseriesforecastcombVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_comb_make_vector(comps : Array[Double]) -> TimeseriesforecastcombVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_comb_vector_zero(dim : Int) -> TimeseriesforecastcombVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesforecastcombVector::add(self : TimeseriesforecastcombVector, other : TimeseriesforecastcombVector) -> TimeseriesforecastcombVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastcombVector::sub(self : TimeseriesforecastcombVector, other : TimeseriesforecastcombVector) -> TimeseriesforecastcombVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastcombVector::scale(self : TimeseriesforecastcombVector, s : Double) -> TimeseriesforecastcombVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesforecastcombVector::dot(self : TimeseriesforecastcombVector, other : TimeseriesforecastcombVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesforecastcombVector::norm(self : TimeseriesforecastcombVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesforecastcombVector::normalize(self : TimeseriesforecastcombVector) -> TimeseriesforecastcombVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastcombVector::dist(self : TimeseriesforecastcombVector, other : TimeseriesforecastcombVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesforecastcombVector::to_string(self : TimeseriesforecastcombVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastcombFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_frame_make(size : Int) -> TimeseriesforecastcombFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastcombFrame::len(self : TimeseriesforecastcombFrame) -> Int { self.size }

pub fn TimeseriesforecastcombFrame::get(self : TimeseriesforecastcombFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastcombFrame::set(self : TimeseriesforecastcombFrame, i : Int, v : Double) -> TimeseriesforecastcombFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombFrame::sum(self : TimeseriesforecastcombFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastcombFrame::mean(self : TimeseriesforecastcombFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastcombFrame::scale(self : TimeseriesforecastcombFrame, f : Double) -> TimeseriesforecastcombFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombFrame::add(self : TimeseriesforecastcombFrame, other : TimeseriesforecastcombFrame) -> TimeseriesforecastcombFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastcombFrame::copy(self : TimeseriesforecastcombFrame) -> TimeseriesforecastcombFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombFrame::fill(self : TimeseriesforecastcombFrame, v : Double) -> TimeseriesforecastcombFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombFrame::min(self : TimeseriesforecastcombFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastcombFrame::max(self : TimeseriesforecastcombFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastcombFrame::to_string(self : TimeseriesforecastcombFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_table_make(size : Int) -> TimeseriesforecastcombTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastcombTable::len(self : TimeseriesforecastcombTable) -> Int { self.size }

pub fn TimeseriesforecastcombTable::get(self : TimeseriesforecastcombTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastcombTable::set(self : TimeseriesforecastcombTable, i : Int, v : Double) -> TimeseriesforecastcombTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombTable::sum(self : TimeseriesforecastcombTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastcombTable::mean(self : TimeseriesforecastcombTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastcombTable::scale(self : TimeseriesforecastcombTable, f : Double) -> TimeseriesforecastcombTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombTable::add(self : TimeseriesforecastcombTable, other : TimeseriesforecastcombTable) -> TimeseriesforecastcombTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastcombTable::copy(self : TimeseriesforecastcombTable) -> TimeseriesforecastcombTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombTable::fill(self : TimeseriesforecastcombTable, v : Double) -> TimeseriesforecastcombTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombTable::min(self : TimeseriesforecastcombTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastcombTable::max(self : TimeseriesforecastcombTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastcombTable::to_string(self : TimeseriesforecastcombTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_graphn_make(size : Int) -> TimeseriesforecastcombGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastcombGraphN::len(self : TimeseriesforecastcombGraphN) -> Int { self.size }

pub fn TimeseriesforecastcombGraphN::get(self : TimeseriesforecastcombGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastcombGraphN::set(self : TimeseriesforecastcombGraphN, i : Int, v : Double) -> TimeseriesforecastcombGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombGraphN::sum(self : TimeseriesforecastcombGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastcombGraphN::mean(self : TimeseriesforecastcombGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastcombGraphN::scale(self : TimeseriesforecastcombGraphN, f : Double) -> TimeseriesforecastcombGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombGraphN::add(self : TimeseriesforecastcombGraphN, other : TimeseriesforecastcombGraphN) -> TimeseriesforecastcombGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastcombGraphN::copy(self : TimeseriesforecastcombGraphN) -> TimeseriesforecastcombGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombGraphN::fill(self : TimeseriesforecastcombGraphN, v : Double) -> TimeseriesforecastcombGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombGraphN::min(self : TimeseriesforecastcombGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastcombGraphN::max(self : TimeseriesforecastcombGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastcombGraphN::to_string(self : TimeseriesforecastcombGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_node_make(size : Int) -> TimeseriesforecastcombNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastcombNode::len(self : TimeseriesforecastcombNode) -> Int { self.size }

pub fn TimeseriesforecastcombNode::get(self : TimeseriesforecastcombNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastcombNode::set(self : TimeseriesforecastcombNode, i : Int, v : Double) -> TimeseriesforecastcombNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombNode::sum(self : TimeseriesforecastcombNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastcombNode::mean(self : TimeseriesforecastcombNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastcombNode::scale(self : TimeseriesforecastcombNode, f : Double) -> TimeseriesforecastcombNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombNode::add(self : TimeseriesforecastcombNode, other : TimeseriesforecastcombNode) -> TimeseriesforecastcombNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastcombNode::copy(self : TimeseriesforecastcombNode) -> TimeseriesforecastcombNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombNode::fill(self : TimeseriesforecastcombNode, v : Double) -> TimeseriesforecastcombNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombNode::min(self : TimeseriesforecastcombNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastcombNode::max(self : TimeseriesforecastcombNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastcombNode::to_string(self : TimeseriesforecastcombNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_edge_make(size : Int) -> TimeseriesforecastcombEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastcombEdge::len(self : TimeseriesforecastcombEdge) -> Int { self.size }

pub fn TimeseriesforecastcombEdge::get(self : TimeseriesforecastcombEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastcombEdge::set(self : TimeseriesforecastcombEdge, i : Int, v : Double) -> TimeseriesforecastcombEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombEdge::sum(self : TimeseriesforecastcombEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastcombEdge::mean(self : TimeseriesforecastcombEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastcombEdge::scale(self : TimeseriesforecastcombEdge, f : Double) -> TimeseriesforecastcombEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombEdge::add(self : TimeseriesforecastcombEdge, other : TimeseriesforecastcombEdge) -> TimeseriesforecastcombEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastcombEdge::copy(self : TimeseriesforecastcombEdge) -> TimeseriesforecastcombEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombEdge::fill(self : TimeseriesforecastcombEdge, v : Double) -> TimeseriesforecastcombEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombEdge::min(self : TimeseriesforecastcombEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastcombEdge::max(self : TimeseriesforecastcombEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastcombEdge::to_string(self : TimeseriesforecastcombEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_path_make(size : Int) -> TimeseriesforecastcombPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastcombPath::len(self : TimeseriesforecastcombPath) -> Int { self.size }

pub fn TimeseriesforecastcombPath::get(self : TimeseriesforecastcombPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastcombPath::set(self : TimeseriesforecastcombPath, i : Int, v : Double) -> TimeseriesforecastcombPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombPath::sum(self : TimeseriesforecastcombPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastcombPath::mean(self : TimeseriesforecastcombPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastcombPath::scale(self : TimeseriesforecastcombPath, f : Double) -> TimeseriesforecastcombPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombPath::add(self : TimeseriesforecastcombPath, other : TimeseriesforecastcombPath) -> TimeseriesforecastcombPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastcombPath::copy(self : TimeseriesforecastcombPath) -> TimeseriesforecastcombPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombPath::fill(self : TimeseriesforecastcombPath, v : Double) -> TimeseriesforecastcombPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombPath::min(self : TimeseriesforecastcombPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastcombPath::max(self : TimeseriesforecastcombPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastcombPath::to_string(self : TimeseriesforecastcombPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_cluster_make(size : Int) -> TimeseriesforecastcombCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastcombCluster::len(self : TimeseriesforecastcombCluster) -> Int { self.size }

pub fn TimeseriesforecastcombCluster::get(self : TimeseriesforecastcombCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastcombCluster::set(self : TimeseriesforecastcombCluster, i : Int, v : Double) -> TimeseriesforecastcombCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombCluster::sum(self : TimeseriesforecastcombCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastcombCluster::mean(self : TimeseriesforecastcombCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastcombCluster::scale(self : TimeseriesforecastcombCluster, f : Double) -> TimeseriesforecastcombCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombCluster::add(self : TimeseriesforecastcombCluster, other : TimeseriesforecastcombCluster) -> TimeseriesforecastcombCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastcombCluster::copy(self : TimeseriesforecastcombCluster) -> TimeseriesforecastcombCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombCluster::fill(self : TimeseriesforecastcombCluster, v : Double) -> TimeseriesforecastcombCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombCluster::min(self : TimeseriesforecastcombCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastcombCluster::max(self : TimeseriesforecastcombCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastcombCluster::to_string(self : TimeseriesforecastcombCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_model_make(size : Int) -> TimeseriesforecastcombModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastcombModel::len(self : TimeseriesforecastcombModel) -> Int { self.size }

pub fn TimeseriesforecastcombModel::get(self : TimeseriesforecastcombModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastcombModel::set(self : TimeseriesforecastcombModel, i : Int, v : Double) -> TimeseriesforecastcombModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombModel::sum(self : TimeseriesforecastcombModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastcombModel::mean(self : TimeseriesforecastcombModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastcombModel::scale(self : TimeseriesforecastcombModel, f : Double) -> TimeseriesforecastcombModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombModel::add(self : TimeseriesforecastcombModel, other : TimeseriesforecastcombModel) -> TimeseriesforecastcombModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastcombModel::copy(self : TimeseriesforecastcombModel) -> TimeseriesforecastcombModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombModel::fill(self : TimeseriesforecastcombModel, v : Double) -> TimeseriesforecastcombModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombModel::min(self : TimeseriesforecastcombModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastcombModel::max(self : TimeseriesforecastcombModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastcombModel::to_string(self : TimeseriesforecastcombModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_layer_make(size : Int) -> TimeseriesforecastcombLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastcombLayer::len(self : TimeseriesforecastcombLayer) -> Int { self.size }

pub fn TimeseriesforecastcombLayer::get(self : TimeseriesforecastcombLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastcombLayer::set(self : TimeseriesforecastcombLayer, i : Int, v : Double) -> TimeseriesforecastcombLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombLayer::sum(self : TimeseriesforecastcombLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastcombLayer::mean(self : TimeseriesforecastcombLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastcombLayer::scale(self : TimeseriesforecastcombLayer, f : Double) -> TimeseriesforecastcombLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombLayer::add(self : TimeseriesforecastcombLayer, other : TimeseriesforecastcombLayer) -> TimeseriesforecastcombLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastcombLayer::copy(self : TimeseriesforecastcombLayer) -> TimeseriesforecastcombLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombLayer::fill(self : TimeseriesforecastcombLayer, v : Double) -> TimeseriesforecastcombLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombLayer::min(self : TimeseriesforecastcombLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastcombLayer::max(self : TimeseriesforecastcombLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastcombLayer::to_string(self : TimeseriesforecastcombLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_buffer_make(size : Int) -> TimeseriesforecastcombBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastcombBuffer::len(self : TimeseriesforecastcombBuffer) -> Int { self.size }

pub fn TimeseriesforecastcombBuffer::get(self : TimeseriesforecastcombBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastcombBuffer::set(self : TimeseriesforecastcombBuffer, i : Int, v : Double) -> TimeseriesforecastcombBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombBuffer::sum(self : TimeseriesforecastcombBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastcombBuffer::mean(self : TimeseriesforecastcombBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastcombBuffer::scale(self : TimeseriesforecastcombBuffer, f : Double) -> TimeseriesforecastcombBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombBuffer::add(self : TimeseriesforecastcombBuffer, other : TimeseriesforecastcombBuffer) -> TimeseriesforecastcombBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastcombBuffer::copy(self : TimeseriesforecastcombBuffer) -> TimeseriesforecastcombBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombBuffer::fill(self : TimeseriesforecastcombBuffer, v : Double) -> TimeseriesforecastcombBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombBuffer::min(self : TimeseriesforecastcombBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastcombBuffer::max(self : TimeseriesforecastcombBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastcombBuffer::to_string(self : TimeseriesforecastcombBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_cursor_make(size : Int) -> TimeseriesforecastcombCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastcombCursor::len(self : TimeseriesforecastcombCursor) -> Int { self.size }

pub fn TimeseriesforecastcombCursor::get(self : TimeseriesforecastcombCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastcombCursor::set(self : TimeseriesforecastcombCursor, i : Int, v : Double) -> TimeseriesforecastcombCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombCursor::sum(self : TimeseriesforecastcombCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastcombCursor::mean(self : TimeseriesforecastcombCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastcombCursor::scale(self : TimeseriesforecastcombCursor, f : Double) -> TimeseriesforecastcombCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombCursor::add(self : TimeseriesforecastcombCursor, other : TimeseriesforecastcombCursor) -> TimeseriesforecastcombCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastcombCursor::copy(self : TimeseriesforecastcombCursor) -> TimeseriesforecastcombCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombCursor::fill(self : TimeseriesforecastcombCursor, v : Double) -> TimeseriesforecastcombCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombCursor::min(self : TimeseriesforecastcombCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastcombCursor::max(self : TimeseriesforecastcombCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastcombCursor::to_string(self : TimeseriesforecastcombCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_view_make(size : Int) -> TimeseriesforecastcombView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastcombView::len(self : TimeseriesforecastcombView) -> Int { self.size }

pub fn TimeseriesforecastcombView::get(self : TimeseriesforecastcombView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastcombView::set(self : TimeseriesforecastcombView, i : Int, v : Double) -> TimeseriesforecastcombView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombView::sum(self : TimeseriesforecastcombView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastcombView::mean(self : TimeseriesforecastcombView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastcombView::scale(self : TimeseriesforecastcombView, f : Double) -> TimeseriesforecastcombView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombView::add(self : TimeseriesforecastcombView, other : TimeseriesforecastcombView) -> TimeseriesforecastcombView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastcombView::copy(self : TimeseriesforecastcombView) -> TimeseriesforecastcombView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombView::fill(self : TimeseriesforecastcombView, v : Double) -> TimeseriesforecastcombView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombView::min(self : TimeseriesforecastcombView) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastcombView::max(self : TimeseriesforecastcombView) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastcombView::to_string(self : TimeseriesforecastcombView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_range_make(size : Int) -> TimeseriesforecastcombRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastcombRange::len(self : TimeseriesforecastcombRange) -> Int { self.size }

pub fn TimeseriesforecastcombRange::get(self : TimeseriesforecastcombRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastcombRange::set(self : TimeseriesforecastcombRange, i : Int, v : Double) -> TimeseriesforecastcombRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombRange::sum(self : TimeseriesforecastcombRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastcombRange::mean(self : TimeseriesforecastcombRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastcombRange::scale(self : TimeseriesforecastcombRange, f : Double) -> TimeseriesforecastcombRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombRange::add(self : TimeseriesforecastcombRange, other : TimeseriesforecastcombRange) -> TimeseriesforecastcombRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastcombRange::copy(self : TimeseriesforecastcombRange) -> TimeseriesforecastcombRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombRange::fill(self : TimeseriesforecastcombRange, v : Double) -> TimeseriesforecastcombRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombRange::min(self : TimeseriesforecastcombRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastcombRange::max(self : TimeseriesforecastcombRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastcombRange::to_string(self : TimeseriesforecastcombRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_slice_make(size : Int) -> TimeseriesforecastcombSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastcombSlice::len(self : TimeseriesforecastcombSlice) -> Int { self.size }

pub fn TimeseriesforecastcombSlice::get(self : TimeseriesforecastcombSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastcombSlice::set(self : TimeseriesforecastcombSlice, i : Int, v : Double) -> TimeseriesforecastcombSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombSlice::sum(self : TimeseriesforecastcombSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastcombSlice::mean(self : TimeseriesforecastcombSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastcombSlice::scale(self : TimeseriesforecastcombSlice, f : Double) -> TimeseriesforecastcombSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombSlice::add(self : TimeseriesforecastcombSlice, other : TimeseriesforecastcombSlice) -> TimeseriesforecastcombSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastcombSlice::copy(self : TimeseriesforecastcombSlice) -> TimeseriesforecastcombSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombSlice::fill(self : TimeseriesforecastcombSlice, v : Double) -> TimeseriesforecastcombSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastcombSlice::min(self : TimeseriesforecastcombSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastcombSlice::max(self : TimeseriesforecastcombSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastcombSlice::to_string(self : TimeseriesforecastcombSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

